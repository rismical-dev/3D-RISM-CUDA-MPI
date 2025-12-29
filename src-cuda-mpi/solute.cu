#include <iostream>
#include <cmath>
#include <limits>
#include "solute.h"

void Solute :: init(int n) {
  num = n;
  cudaMallocHost(&q, num * sizeof(double));
  cudaMallocHost(&r, num * 3 * sizeof(double));
//  cudaMallocHost(&sig, num * sizeof(double));
//  cudaMallocHost(&eps, num * sizeof(double));
//  q = new double[num];
  sig = new double[num];
  eps = new double[num];
//  r = new double[num * 3];
}

double * Solute :: centering() {
  double xmin, ymin, zmin, xmax, ymax, zmax;
  double * shift;
  shift = new double[3];

  xmin = ymin = zmin = std::numeric_limits<double>::max();
  xmax = ymax = zmax = std::numeric_limits<double>::lowest();

  for (int n = 0; n < num; ++n) {
    int i = n * 3;
    if (xmin > r[i]) xmin = r[i];
    if (ymin > r[i + 1]) ymin = r[i + 1];
    if (zmin > r[i + 2]) zmin = r[i + 2];
    if (xmax < r[i]) xmax = r[i];
    if (ymax < r[i + 1]) ymax = r[i + 1];
    if (zmax < r[i + 2]) zmax = r[i + 2];
  }

  shift[0] = round(- (xmax - xmin) / 2 - xmin);
  shift[1] = round(- (ymax - ymin) / 2 - ymin);
  shift[2] = round(- (zmax - zmin) / 2 - zmin);

  for (int n = 0; n < num; ++n) {
    int i = n * 3;
    r[i] += shift[0];
    r[i + 1] += shift[1];
    r[i + 2] += shift[2];
  }

 return shift;
}

void Solute :: zero() {
  for (int n = 0; n < num; ++n) {
    q[n] = 0.0;
  }
}

void Solute :: setup_mpi() {
  MPI_Bcast(q, num, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(sig, num, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(eps, num, MPI_DOUBLE, 0, MPI_COMM_WORLD);
  MPI_Bcast(r, num * 3, MPI_DOUBLE, 0, MPI_COMM_WORLD);
}

void Solute :: setup_cuda() {
  cudaMalloc(&dq, num * sizeof(double));
  cudaMalloc(&dr, num * sizeof(double3));
  cudaMemcpy(dq, q, num * sizeof(double), cudaMemcpyDefault);
  cudaMemcpy(dr, r, num * sizeof(double3), cudaMemcpyDefault);
}
