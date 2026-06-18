#include <thrust/device_vector.h>
#include "rism3d.h"

__constant__ double3 dv;
__constant__ int3 grid;

void RISM3D :: cal_euv (double * & e) {
  __global__ void euv(double * ds, double2 * dguv, double * dsig,
                      double * deps,  double3 * dr, double * qu, double gv,
                      int natu, int iv, int iu, int yy, int zz);

  int ng = ce -> mgrid;		      

  cudaMemcpyToSymbol(dv, ce -> dr, sizeof(double3));
  cudaMemcpyToSymbol(grid, ce -> grid, sizeof(int3));
  double * ds2;
  cudaMalloc(&ds2, gr.x * gr.y * 2 * sizeof(double));

  for (size_t iv = 0; iv < sv -> natv; ++iv) {
    for (size_t iu = 0; iu < su -> num; ++iu) {
      euv <<< gr, br, br.x * 2 * sizeof(double) >>>
        (ds2, dguv + iv * ng, dsig, deps, su -> dr, su -> dq, sv -> qv[iv], 
         su -> num, iv, iu, ce -> ystart, ce -> zstart);
      thrust::device_ptr<double> ds2_ptr(ds2);
      for (int i = 0; i < 2; ++i) {
        double s = thrust::reduce(ds2_ptr + (gr.x * gr.y) * i,
                                  ds2_ptr + (gr.x * gr.y) * (i + 1));
        e[(sv -> natv * su -> num) * i + su -> num * iv + iu] =
	  s * sv -> rhov[iv];
      }
    }
  }
}

__global__ void euv(double * ds, double2 * dguv, double * dsig,
                    double * deps,  double3 * dr, double * qu,
                    double qv, int natu, int iv, int iu, int yy, int zz) {
  extern __shared__ double sdata[];
  const double cc = hartree * bohr * avogadoro;

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;
  int iuv = iu + iv * natu;

  double dx = ((int)threadIdx.x - grid.x / 2) * dv.x - dr[iu].x;
  double dy = ((int)blockIdx.x + yy - grid.y / 2) * dv.y - dr[iu].y;
  double dz = ((int)blockIdx.y + zz - grid.z / 2) * dv.z - dr[iu].z;
  double r2 = dx * dx + dy * dy + dz * dz;
  double r1 = sqrt(r2);

  if (r1 < dsig[iuv] * 0.5) {
    sdata[threadIdx.x] = 0.0;
    sdata[threadIdx.x + blockDim.x] = 0.0;
  } else {
    double rs2i = dsig[iuv] * dsig[iuv] / r2;
    double rs6i = rs2i * rs2i * rs2i;
    double ulj = deps[iuv] * 4.0 * rs6i * ( rs6i - 1.0) * dguv[ip].x;
    double uco = qu[iu] * qv / r1 * cc * dguv[ip].x;
    sdata[threadIdx.x] = ulj;
    sdata[threadIdx.x + blockDim.x] = uco;
  }
  __syncthreads();

  for (unsigned int s = blockDim.x / 2; s > 0; s >>= 1) {
    if (threadIdx.x < s) {
      sdata[threadIdx.x] += sdata[threadIdx.x + s];
      sdata[threadIdx.x + blockDim.x] += sdata[threadIdx.x + blockDim.x + s];
    }
    __syncthreads();
  }
  if (threadIdx.x == 0) {
    ds[blockIdx.x + blockIdx.y * gridDim.x] = sdata[0];
    ds[blockIdx.x + blockIdx.y * gridDim.x + gridDim.x * gridDim.y] =
      sdata[blockDim.x];
  }
}



/*
__global__ void ehnc(double * ds, double2 * dhuv, double * dt) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  sdata[threadIdx.x] = dhuv[ip].x * 0.5 * dt[ip] - (dhuv[ip]. x - dt[ip]);
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
*/