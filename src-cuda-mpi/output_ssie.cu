#include <iostream>
#include <fstream>
#include "rism3d.h"
#include "extension.h"

void RISM3D :: output_ssie(double * & ssie) {

  cout << "outputting ssie to file:  " << fname + extssie << "  ..." << endl;

  ofstream out_file;
  out_file.open ((fname + extssie).c_str());

  double dv = ce -> dv;

  for (size_t iu = 0; iu < su -> num; ++iu) {
    double ssiea = 0.0;
    size_t i = iu * 2;
//    for (size_t iv = 0; iv < sv -> natv; ++iv) {
//      euva += ssie[i + iv];
//    }
//    out_file << fixed << dv * euva;
    for (size_t iv = 0; iv < 2; ++iv) {
      out_file << " " << fixed << dv * ssie[i + iv];
    }
    out_file << endl;
  }

  cout << "done." << endl;

  out_file.close();
} 
