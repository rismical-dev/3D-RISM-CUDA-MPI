#include "rism3d.h"

void RISM3D :: cal_potential() {
  __global__ void set_du(double * du, double * de, double q);
#ifdef TEST
  double t[5];
  t[0] = MPI_Wtime();
#endif

  cal_LJ();
#ifdef TEST
  t[1] = MPI_Wtime();
#endif
  cal_Coulomb();
#ifdef TEST
  t[2] = MPI_Wtime();
#endif

//  for (int iv = 0; iv < sv -> natv; ++iv) {
//    set_du <<< gr, br >>> (du + (iv * ce -> mgrid), de, sv -> qv[iv]);
//  }
#ifdef TEST
  t[3] = MPI_Wtime();
#endif
//  cudaFree(dgv);
//  cudaFree(de);
#ifdef TEST
  t[4] = MPI_Wtime();
  if (myrank == 0) {
    printf("LJ          :\t%lf sec.\n", t[1] - t[0]);
    printf("Coulomb     :\t%lf sec.\n", t[2] - t[1]);
    printf("Summation   :\t%lf sec.\n", t[3] - t[2]);
//    printf("cudaFree    :\t%lf sec.\n", t[4] - t[3]);
  }
#endif
}


__global__ void set_du(double * du, double * de, double q) {
  unsigned int ip = threadIdx.x + blockIdx.x * blockDim.x 
    + blockIdx.y * blockDim.x * gridDim.x;
  du[ip] += q * de[ip];
}
