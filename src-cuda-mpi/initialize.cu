#include <sched.h>
#include "rism3d.h"

void RISM3D :: initialize(string control, string structure, bool centering, 
                          bool q0, int dn) {
#ifdef TEST
  double t[4];
  t[0] = MPI_Wtime();
#endif

/*
  cpu_set_t cpu;

  // binding CPU core 0,2,4,6,8,10 in socket 0.
  CPU_ZERO(&cpu);
  for (int i = 1; i < 6; i++)
    CPU_SET(i * 2, &cpu);
  sched_setaffinity(0, sizeof(cpu), &cpu);
*/

  zero = q0;
  set_mpi();
  set_device(dn);
  read_input(control, structure, centering);
  set_cuda();
  set_fname(control, structure);
#ifdef TEST
  t[1] = MPI_Wtime();
#endif
  initialize_g();
#ifdef TEST
  t[2] = MPI_Wtime();
#endif
  set_solvent();
#ifdef TEST
  t[3] = MPI_Wtime();
  if (myrank == 0) {
    printf("Initialize1 :\t%lf sec.\n", t[1] - t[0]);
    printf("Initialize2 :\t%lf sec.\n", t[2] - t[1]);
    printf("Initialize3 :\t%lf sec.\n", t[3] - t[2]);
  }
#endif
  cal_potential();
} 
