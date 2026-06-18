#include <iostream>
#include <fstream>
#include <iomanip>
#include "rism3d.h"
#include "extension.h"

void RISM3D :: output_euv(double * & euv) {

  cout << "outputting euv to file:  " << fname + exteuv << "  ..." << endl;

  ofstream out_file;
  out_file.open ((fname + exteuv).c_str());

  double dv = ce -> dv;
  for (size_t iu = 0; iu < su -> num; ++iu) {
    for (size_t iv = 0; iv < sv -> natv; ++iv) {
      out_file << scientific << setw(16) << setprecision(8)
               << euv[su -> num * iv + iu] * dv << " ";
    }
    for (size_t iv = 0; iv < sv -> natv; ++iv) {
      size_t i = su -> num * sv -> natv;
      out_file << scientific << setw(16) << setprecision(8)
               << euv[su -> num * iv + i + iu] * dv << " ";
    }
    out_file << endl;
  }

  cout << "done." << endl;

  out_file.close();
} 
