#include <iostream>
#include <fstream>
#include <iomanip>
#include "rism3d.h"
#include "extension.h"

void RISM3D :: output_ad(double * & ad) {

  std::stringstream ss;
  ss << fname << "-" << adswitch << "-" << lambda;

  cout << "outputting ad to file:  " << ss.str() << "  ..." << endl;

  ofstream out_file;
  out_file.open (ss.str().c_str());

  double dv = ce -> dv;
  for (int iu = 0; iu < su -> num; ++iu) {
    out_file << scientific 
             << setw(16) << setprecision(8) << ad[iu] * dv << endl;
  }

  cout << "done." << endl;

  out_file.close();
} 
