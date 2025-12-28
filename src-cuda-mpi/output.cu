#include <algorithm>
#include <iostream>
#include <fstream>
#include "rism3d.h"

void RISM3D :: output() {

  transform(outlist.begin(), outlist.end(), outlist.begin(), ::tolower);

  int flag = 0;
  if (myrank == 0) {
    if (outlist.find("m") != string::npos) flag += 1;
    if (outlist.find("d") != string::npos) flag += 2;
    if (outlist.find("c") != string::npos) flag += 4;
    if (outlist.find("g") != string::npos) flag += 8;
    if (outlist.find("h") != string::npos) flag += 16;
    if (outlist.find("a") != string::npos) flag += 32;
    if (outlist.find("b") != string::npos) flag += 64;
  }

  MPI_Bcast(&flag, 1, MPI_INT, 0, MPI_COMM_WORLD);

  if ((flag & 1) == 1) {
    double pmv = cal_pmv();
    double pressure = cal_pressure();
    double * xmu = new double[sv -> natv * 2];
    double * xmu2 = new double[sv -> natv];    

    cal_exchem(xmu, xmu2);

    double * xmu0;
    double * xmu20;
    if (myrank == 0) {
      xmu0 = new double[sv -> natv * 2];
      xmu20 = new double[sv -> natv];      
    }
    MPI_Reduce(xmu, xmu0, sv -> natv * 2, MPI_DOUBLE, MPI_SUM, 0,
    	       MPI_COMM_WORLD);
    MPI_Reduce(xmu2, xmu20, sv -> natv, MPI_DOUBLE, MPI_SUM, 0,
    	       MPI_COMM_WORLD);
    if (myrank == 0) {
      output_xmu(xmu0, xmu20, pmv, pressure);
      delete[] xmu0, xmu20;
    }
    delete[] xmu, xmu2;
  }

  if ((flag & 2) == 2) {
    double * du;
    double * du2;
    du = new double[su -> num * 3];
    cal_grad(du);
    if (myrank == 0) du2 = new double[su -> num * 3];
    MPI_Reduce(du, du2, su -> num * 3, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    if (myrank == 0) {
      output_grad(du2);
      delete[] du2;
    }
    delete[] du;
  }

  if ((flag & 4) == 4) {
    output_cuv();
  }

  if ((flag & 8) == 8) {
    output_guv();
  }

  if ((flag & 16) == 16) {
    output_huv();
  }

  if ((flag & 32) == 32) {
    double * ad;
    double * ad2;
    ad = new double[su -> num];
    if (adswitch == 1) {
      cal_ad1(ad);
    } else {
      cal_ad2(ad);
    }
    if (myrank == 0) ad2 = new double[su -> num];
    MPI_Reduce(ad, ad2, su -> num, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
    if (myrank == 0) {
      output_ad(ad2);
      delete[] ad2;
    }
    delete[] ad;
  }

  if ((flag & 64) == 64) {
    double * euv;
    double * euv2;
    euv = new double[su -> num * sv -> natv];
    cal_euv(euv);
    if (myrank == 0) euv2 = new double[su -> num * sv -> natv];
    MPI_Reduce(euv, euv2, su -> num * sv -> natv, MPI_DOUBLE, MPI_SUM, 0, 
               MPI_COMM_WORLD);
    if (myrank == 0) {
      output_euv(euv2);
      delete[] euv2;
    }
    delete[] euv;
  }
}
