#include <iostream>
#include <thrust/device_vector.h>
#include "rism3d.h"

double RISM3D :: cal_pmv () {
  __global__ void pmv0(double * ds, double2 * dhuv, double * dt);

  double cuv = 0.0;
  for (int iv = 0; iv < sv -> natv; ++iv) {
    pmv0 <<< gr, br, br.x * sizeof(double) >>>
      (ds, dhuv + (iv * ce -> mgrid), dt + (iv * ce -> mgrid));
    thrust::device_ptr<double> ds_ptr(ds);
    double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
    cuv += s * sv -> rhov[iv];
  }

  double cuva;
  MPI_Reduce(&cuv, &cuva, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
  cuv = cuva * ce -> dv;

  double ibeta = avogadoro * boltzmann * sv -> temper;
  double pmv = sv -> xt * (1.0 - cuv) * ibeta;

  return pmv;
}


__global__ void pmv0(double * ds, double2 * dhuv, double * dt) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  sdata[threadIdx.x] = dhuv[ip].x - dt[ip];
  __syncthreads();

  for (unsigned int s = blockDim.x / 2; s > 32; s >>= 1) {
    if (threadIdx.x < s) {
      sdata[threadIdx.x] += sdata[threadIdx.x + s];
    }
    __syncthreads();
  }
  if (threadIdx.x < 32) {
    volatile double *smem = sdata;
    smem[threadIdx.x] += smem[threadIdx.x + 32];
    __syncwarp();
    smem[threadIdx.x] += smem[threadIdx.x + 16];
    __syncwarp();
    smem[threadIdx.x] += smem[threadIdx.x + 8];
    __syncwarp();
    smem[threadIdx.x] += smem[threadIdx.x + 4];
    __syncwarp();
    smem[threadIdx.x] += smem[threadIdx.x + 2];
    __syncwarp();
    smem[threadIdx.x] += smem[threadIdx.x + 1];
  }
  if (threadIdx.x == 0) ds[blockIdx.x + blockIdx.y * gridDim.x] = sdata[0];
}
