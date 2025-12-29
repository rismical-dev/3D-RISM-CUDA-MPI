#ifndef SOLUTE_H
#define SOLUTE_H
#include <stdlib.h>
#include <mpi.h>

class Solute {
 public:
  Solute(){}
  ~Solute(){delete[] q, sig, eps, r;}
  void init(int);
  double * centering();
  void zero();
  void setup_cuda();
  void setup_mpi();
  double * q;
  double * sig;
  double * eps;
  double * r;
  double * dq;
  double3 * dr;
  int num;
};

#endif
