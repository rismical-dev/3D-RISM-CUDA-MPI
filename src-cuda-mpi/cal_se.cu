#include <thrust/device_vector.h>
#include "rism3d.h"

void RISM3D :: cal_se (double * & xmu) {
  __global__ void se_lj(double *, double2 *, const double * __restrict__,
                        const double * __restrict__, double);
  __global__ void se_elec(double *, double2 *, const double * __restrict__,
                          const double * __restrict__, double);

  for (int iv = 0; iv < sv -> natv; ++iv) {
    se_lj <<< gr, br, br.x * sizeof(double) >>>
      (ds, dguv + (iv * ce -> mgrid),
       du + (iv * ce -> mgrid), de, sv -> qv[iv]);
    thrust::device_ptr<double> ds_ptr(ds);
    double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
    xmu[iv] = s * sv -> rhov[iv];
  }

  for (int iv = 0; iv < sv -> natv; ++iv) {
    se_elec <<< gr, br, br.x * sizeof(double) >>>
      (ds, dguv + (iv * ce -> mgrid),
       du + (iv * ce -> mgrid), de, sv -> qv[iv]);
    thrust::device_ptr<double> ds_ptr(ds);
    double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
    xmu[sv -> natv + iv] = s * sv -> rhov[iv];
  }

  for (int iv = 0; iv < sv -> natv * 2; ++iv) {
    xmu[iv] = xmu[iv] * ce -> dv;
  }
} 

__global__ void se_lj(double * ds, double2 * dguv,
 	              const double * __restrict__ du,
		      const double * __restrict__ de, double q) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  sdata[threadIdx.x] = dguv[ip].x * du[ip];
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

__global__ void se_elec(double * ds, double2 * dguv,
	                const double * __restrict__ du,
			const double * __restrict__ de, double q) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  sdata[threadIdx.x] = dguv[ip].x * de[ip] * q;
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
