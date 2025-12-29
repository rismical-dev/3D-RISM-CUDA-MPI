#include <iostream>
#include <fstream>
#include <unistd.h>
#include "rism3d.h"

int main (int argc, char * argv[]) {
  RISM3D * system;
  int ch, cu, dn;
  string input;
  string structure;
  bool centering = true;  
  bool q0 = false;

  system = new RISM3D;

  while ((ch = getopt(argc, argv, "c:i:s:l:e:f:z")) != -1) {
    switch (ch){
    case 'c':
      cu = atoi(optarg);
      break;
    case 'i':
      input = optarg;
      break;
    case 's':
      structure = optarg;
      break;
    case 'l':
      system -> set_ad (atof(optarg), 1);
      break;
    case 'e':
      system -> set_ad (atof(optarg), 2);
      break;
    case 'f':
      centering = false;
      break;
    case 'z':
      q0 = true;
      break;
    }
  }

  if (input.empty() || structure.empty()) {
    if (argv[optind] == NULL) {
      cout << "No input file!" << endl;
      return (1);
    }
    input = argv[optind];
  }

#ifdef OPENMPI
  dn = atoi(getenv("OMPI_COMM_WORLD_LOCAL_RANK"));
#endif
#ifdef MVAPICH
  dn = atoi(getenv("MV2_COMM_WORLD_LOCAL_RANK"));
#endif

  cudaSetDevice(dn);

  MPI_Init(&argc, &argv);
  //  int provided;
  //  MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &provided);

  system -> initialize(input, structure, centering, q0, dn);
  system -> iterate();
  system -> output();    

  MPI_Finalize();
  return(0);
}
