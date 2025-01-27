#ifndef AN2_H
#define AN2_H

#include <valarray>
#include <vector>
#include <mpi.h>
#include "cell.h"
#include "solvent.h"
using namespace std;

class AN2 {
public:
  AN2 () {}
  ~AN2 ();
  void initialize (Cell *, Solvent *);
  void calculate (double *, double *, double &);
  void setup_mpi();
  double m;
  double mp;
  int count;
private:
  void cal_theta (double *, double *);
  vector <double *> tp;
  vector <double *> rp;
  double * dtp;
  double * drp;
  double * irho;
  double * s;
  double * ss;
  double * ds;
  double * a;
  double * c;
  double * x;
  double s0;
  double s1;
  double s2;
  double theta;
  int niv;
  int ngrid;
  int binary;
  dim3 b;
  dim3 gr;
};

#endif // AN2_H
