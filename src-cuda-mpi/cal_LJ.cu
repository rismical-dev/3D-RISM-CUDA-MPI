#include <iostream>
#include "rism3d.h"

void RISM3D :: cal_LJ() {
  __global__ void LJ(double * du, double * dsig, double * deps, double3 * dru,
		     double cut2, double ikbt, double bx, double by, double bz,
		     int nx, int ny, int nz, int natu, int iv, int ystart, int zstart);
  __global__ void time_iKbT(double * du, double ikbt);

//  const double cut = 1.0e-2;
  const double cut = 2.0e-3;
  const double cut2 = cut * cut;

  if (myrank == 0) {
    cout << "tabulating solute Lennard-Jones potential ..." << endl;
  }

  cudaMalloc(&du, ce -> mgrid * sv -> natv * sizeof(double));
  cudaMalloc(&dsig, su -> num * sv -> natv * sizeof(double));
  cudaMalloc(&deps, su -> num * sv -> natv * sizeof(double));
  cudaMemset(du, 0.0, ce -> mgrid * sv -> natv * sizeof(double));

  cudaMallocHost(&siguv, su -> num * sv -> natv * sizeof(double));
  cudaMallocHost(&epsuv, su -> num * sv -> natv * sizeof(double));

  double lambda1 = 1.0;
  if (adswitch == 1) lambda1 = lambda;

  for (int iv = 0; iv < sv -> natv; ++iv) {
#pragma omp parallel for
    for (int iu = 0; iu < su -> num; ++iu) {
      int ip = iu + su -> num * iv;
      siguv[ip] = (su -> sig[iu] + sv -> sigv[iv]) * 0.5 * lambda1;
      epsuv[ip] = sqrt (su -> eps[iu] * sv -> epsv[iv]);
    }
  }

  cudaMemcpy(dsig, siguv, su -> num * sv -> natv * sizeof(double),
	     cudaMemcpyDefault);
  cudaMemcpy(deps, epsuv, su -> num * sv -> natv * sizeof(double),
	     cudaMemcpyDefault);

  double iKbT = 1.0 / (avogadoro * boltzmann * sv -> temper);
  for (int iv = 0; iv < sv -> natv; ++iv) {
    LJ <<< gr, br >>> (du + (iv * ce -> mgrid), dsig, deps, su -> dr, 
		      cut2, iKbT, ce -> dr[0], ce -> dr[1], ce -> dr[2], 
		      ce -> grid[0], ce -> grid[1], ce -> grid[2], 
		      su -> num, iv, ce -> ystart, ce -> zstart);
  }
}

__global__ void LJ(double * du, double * dsig, double * deps, double3 * dru,
                   double cut2, double ikbt, double bx, double by, double bz,
                   int nx, int ny, int nz, int natu, int iv, int yy, int zz) {
  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x
    + blockIdx.y * blockDim.x * gridDim.x;
  double rx = ((int)threadIdx.x - nx / 2) * bx;
  double ry = ((int)blockIdx.x + yy - ny / 2) * by;
  double rz = ((int)blockIdx.y + zz - nz / 2) * bz;
  for (int iu = 0; iu < natu; ++iu) {
    int iuv = iu + natu * iv;
    double dx = rx - dru[iu].x;
    double dy = ry - dru[iu].y;
    double dz = rz - dru[iu].z;
    double r2 = dx * dx + dy * dy + dz * dz ;

//    if (r2 < cut2) r2 = cut2;
//    double irs2 = dsig[iuv] * dsig[iuv] / r2;
//    double irs6 = irs2 * irs2 * irs2;

    double rs2 = r2 / (dsig[iuv] * dsig[iuv]);
    if (rs2 < cut2) rs2 = cut2;
    double irs6 = 1.0 / (rs2 * rs2 * rs2);
    du[ip] += deps[iuv] * 4.0 * irs6 * (irs6 - 1.0);
  }
  du[ip] *= ikbt;
}
