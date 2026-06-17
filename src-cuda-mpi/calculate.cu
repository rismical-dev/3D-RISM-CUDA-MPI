#include <iostream>
#include "rism3d.h"

void RISM3D :: calculate (double & ft) {
  __global__ void kh(double * dtr, double * dt, double * du, double * de,
                     double q);
  __global__ void hnc(double * dtr, double * dt, double * du, double * de,
                      double q);
  __global__ void trm1mt(double2 * dguv, double * dtr, double * dt,
                         double * dfr, double qv);
  __global__ void mqvfk(double2 * dguv, double2 * dfk, double qv);
  __global__ void oz(double2 * dhuv, double2 * dguv, double * dx, int natv);
  __global__ void tr(double2 * dguv, double * dtr, double2 * dhuv);

  int ng = ce -> mgrid;

  if (clos == 0) {
    for (int iv = 0; iv < sv -> natv; ++iv) {
      kh <<< gr, br >>> (dtr + (iv * ng), dt + (iv * ng), du + (iv * ng),
                         de, sv -> qv[iv]);
    }
  } else if (clos == 1) {
    for (int iv = 0; iv < sv -> natv; ++iv) {
      hnc <<< gr, br >>> (dtr + (iv * ng), dt + (iv * ng), du + (iv * ng),
                          de, sv -> qv[iv]);
    }
  } 

  for (int iv = 0; iv < sv -> natv; ++iv) {
    trm1mt <<< gr, br >>> (dguv + (iv * ng), dtr + (iv * ng),
		 	  dt + (iv * ng), dfr, sv -> qv[iv]);
  }

#ifdef TEST
  double fs, fe;
  fs = MPI_Wtime();
#endif
  for (int iv = 0; iv < sv -> natv; ++iv) {
    fft -> execute(dguv + (iv * ng), - 1);
  }
#ifdef TEST
  fe = MPI_Wtime();
  ft += fe - fs;
#endif

  for (int iv = 0; iv < sv -> natv; ++iv) {
    mqvfk <<< gk, bk >>> (dguv + (iv * ng), dfk, sv -> qv[iv]);
  }

  for (int iv = 0; iv < sv -> natv; ++iv) {
    oz <<< gk, bk >>> (dhuv + (iv * ng), dguv,
		      sv -> dx + (iv * sv -> natv * ng), sv -> natv);
  }

#ifdef TEST
  fs = MPI_Wtime();
#endif
  for (int iv = 0; iv < sv -> natv; ++iv) {
    fft -> execute(dhuv + (iv * ng), 1);
  }
#ifdef TEST
  fe = MPI_Wtime();
  ft += fe - fs;
#endif

  for (int iv = 0; iv < sv -> natv; ++iv) {
    tr <<< gr, br >>> (dguv + (iv * ng), dtr + (iv * ng), dhuv + (iv * ng));
  }
} 
