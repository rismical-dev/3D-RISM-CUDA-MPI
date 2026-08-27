#!/bin/bash
#------- qsub option ----------- 
#PBS -A PRORISM
#PBS -q gpu
#PBS -b 1
#PBS -l elapstim_req=24:00:00 
#PBS -T openmpi
#PBS -v NQSV_MPI_VER=gcc8.3.1-cuda10.2-ucx1.7.0
#PBS -v OMP_NUM_THREADS=6
#------- Program execution ----------- 
module load use.own
module load gcc/8.3.1
module load gcc8.3.1-cuda10.2-ucx1.7.0
INP=gpcr.inp
cd $PBS_O_WORKDIR
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.025 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.05 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.075 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.1 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.125 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.15 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.175 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.2 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.225 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.25 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.275 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.3 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.325 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.35 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.375 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.4 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.425 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.45 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.475 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.5 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.525 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.55 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.575 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.6 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.625 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.65 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.675 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.7 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.725 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.75 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.775 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.8 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.825 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.85 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.875 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.9 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.925 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.95 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 0.975 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -1 1.0 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.001 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.005 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.01 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.025 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.05 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.075 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.1 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.125 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.15 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.175 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.2 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.225 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.25 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.275 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.3 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.325 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.35 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.375 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.4 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.425 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.45 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.475 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.5 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.525 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.55 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.575 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.6 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.625 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.65 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.675 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.7 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.725 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.75 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.775 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.8 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.825 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.85 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.875 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.9 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.925 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.95 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 0.975 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -2 1.0 $INP
