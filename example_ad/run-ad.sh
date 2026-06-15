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
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.025 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.05 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.075 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.1 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.125 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.15 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.175 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.2 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.225 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.25 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.275 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.3 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.325 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.35 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.375 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.4 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.425 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.45 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.475 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.5 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.525 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.55 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.575 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.6 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.625 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.65 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.675 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.7 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.725 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.75 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.775 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.8 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.825 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.85 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.875 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.9 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.925 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.95 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 0.975 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -l 1.0 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.001 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.005 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.01 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.025 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.05 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.075 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.1 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.125 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.15 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.175 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.2 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.225 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.25 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.275 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.3 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.325 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.35 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.375 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.4 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.425 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.45 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.475 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.5 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.525 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.55 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.575 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.6 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.625 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.65 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.675 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.7 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.725 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.75 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.775 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.8 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.825 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.85 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.875 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.9 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.925 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.95 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 0.975 $INP
mpirun ${NQSII_MPIOPTS} -np 4 -npernode 4 ./3drism-cuda-mpi -e 1.0 $INP
