#include <thrust/device_vector.h>
#include "rism3d.h"

void RISM3D :: cal_exchem (double * & xmu, double * & xmu2) {
  __global__ void ekh(double * ds, double2 * dhuv, double * dt);
  __global__ void ehnc(double * ds, double2 * dhuv, double * dt);
  __global__ void egf(double * ds, double2 * dhuv, double * dt);

  if (clos == 0) {
    for (int iv = 0; iv < sv -> natv; ++iv) {
      ekh <<< gr, br, br.x * sizeof(double) >>>
	(ds, dhuv + (iv * ce -> mgrid), dt + (iv * ce -> mgrid));
      thrust::device_ptr<double> ds_ptr(ds);
      double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
      xmu[iv] = s * sv -> rhov[iv];
    }
  } else if (clos == 1) {
    for (int iv = 0; iv < sv -> natv; ++iv) {
      ehnc <<< gr, br, br.x * sizeof(double) >>>
	(ds, dhuv + (iv * ce -> mgrid), dt + (iv * ce -> mgrid));
      thrust::device_ptr<double> ds_ptr(ds);
      double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
      xmu[iv] = s * sv -> rhov[iv];
    }
  } 

  if (clos == 0) {
    for (int iv = 0; iv < sv -> natv; ++iv) {
      ehnc <<< gr, br, br.x * sizeof(double) >>>
        (ds, dhuv + (iv * ce -> mgrid), dt + (iv * ce -> mgrid));
      thrust::device_ptr<double> ds_ptr(ds);
      double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
      xmu2[iv] = s * sv -> rhov[iv];
    }
  }

  for (int iv = 0; iv < sv -> natv; ++iv) {
    egf <<< gr, br, br.x * sizeof(double) >>>
      (ds, dhuv + (iv * ce -> mgrid), dt+(iv * ce -> mgrid));
    thrust::device_ptr<double> ds_ptr(ds);
    double s = thrust::reduce(ds_ptr, ds_ptr + gr.x * gr.y);
    xmu[sv -> natv + iv] = s * sv -> rhov[iv];
  }

  for (int iv = 0; iv < sv -> natv * 2; ++iv) {
    xmu[iv] = xmu[iv] * ce -> dv;
  }

  for (int iv = 0; iv < sv -> natv; ++iv) {
    xmu2[iv] = xmu2[iv] * ce -> dv;
  }
}


__global__ void ekh(double * ds, double2 * dhuv, double * dt) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  if (dhuv[ip].x > 0.0) {
    sdata[threadIdx.x] = -(dhuv[ip].x * 0.5 + 1.0) * (dhuv[ip]. x - dt[ip]);
  } else {
    sdata[threadIdx.x] = dhuv[ip].x * 0.5 * dt[ip] - (dhuv[ip]. x - dt[ip]);
  }
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


__global__ void egf(double * ds, double2 * dhuv, double * dt) {
  extern __shared__ double sdata[];

  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;

  sdata[threadIdx.x] = -(dhuv[ip].x * 0.5 + 1.0) * (dhuv[ip]. x - dt[ip]);
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
