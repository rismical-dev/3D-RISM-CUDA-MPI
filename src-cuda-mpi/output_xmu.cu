#include <iostream>
#include <fstream>
#include <iomanip>
#include "rism3d.h"
#include "extension.h"

void RISM3D :: output_xmu(double * & xmu, double * & xmu2,
                          double pmv, double pressure) {
    
  ofstream out_file;
  out_file.open((fname + extxmu).c_str());

  double ibeta = avogadoro * boltzmann * sv -> temper;

  double xmua = 0.0;
  for (int iv = 0; iv < sv -> natv; ++iv) {
    xmua += xmu[iv];
  }

  double pcterm = - pressure * pmv * ibeta;

  out_file << " $RESULTS" << endl;

  out_file << "SFE_SC= " << fixed << setprecision(5)
           << ibeta * xmua << " !(J/mol)" << endl;

  for (int iv = 0; iv < sv -> natv; ++iv) {
    out_file << "  SFEC_SC(" << iv << ")= " << fixed << setprecision(5)
             << ibeta * xmu[iv] << endl;
  }
  out_file << endl;

  if (clos == 0) {
    xmua = 0.0;
    for (int iv = 0; iv < sv -> natv; ++iv) {
      xmua += xmu2[iv];
    }

    out_file << "SFE_SC_HNC= " << fixed << setprecision(5)
             << ibeta * xmua << " !(J/mol)" << endl;

    for (int iv = 0; iv < sv -> natv; ++iv) {
      out_file << "  SFEC_SC_HNC(" << iv << ")= " << fixed << setprecision(5)
               << ibeta * xmu2[iv] << endl;
    }
    out_file << endl;
  }

  xmua = 0.0;

  for (int iv = 0; iv < sv -> natv; ++iv) {
    xmua += xmu[sv -> natv + iv];
  }

  out_file << "SFE_GF= " << fixed << setprecision(5)
           << ibeta * xmua << " !(J/mol)" << endl;

  for (int iv = 0; iv < sv -> natv; ++iv) {
    out_file << "  SFEC_GF(" << iv << ")= " << fixed << setprecision(5)
    	     << ibeta * xmu[sv -> natv + iv] << endl;
  }
  out_file << endl;

  out_file << "PMV= " << fixed << setprecision(5)
           << pmv * 1000 << " !(L/mol)" << endl;

  out_file << "Pressure= " << fixed << setprecision(5)
           << ibeta * pressure << " !(J/m^3)" << endl;

  out_file << "Correction_Term= " << fixed << setprecision(5)
             << pcterm << " !(J/mol)" << endl;

  out_file << " $END" << endl;

  out_file.close();
} 
