#include <iostream>
#include <fstream>
#include <iomanip>
#include "rism3d.h"
#include "extension.h"

void RISM3D :: output_grad(double * & du) {

  cout << "outputting grad to file:  " << fname + extgra << "  ..." << endl;

  ofstream out_file;
  out_file.open ((fname + extgra).c_str());

  double dv = ce -> dv;
  for (int iu = 0; iu < su -> num; ++iu) {
    int num = iu * 6;
    out_file << scientific 
             << setw(16) << setprecision(8) << du[num] * dv << " "
	     << setw(16) << setprecision(8) << du[num + 1] * dv << " "
	     << setw(16) << setprecision(8) << du[num + 2] * dv << " "
             << setw(16) << setprecision(8) << du[num + 3] * dv << " "
	     << setw(16) << setprecision(8) << du[num + 4] * dv << " "
	     << setw(16) << setprecision(8) << du[num + 5] * dv << endl;
  }

  cout << "done." << endl;

  out_file.close();
} 
