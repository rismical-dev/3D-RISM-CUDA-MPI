#!/bin/bash
#------- qsub option -----------
#PBS -A PRORISM
#PBS -q gpu
#PBS -b 4
#PBS -l elapstim_req=01:00:00
#PBS -T openmpi
#PBS -v NQSV_MPI_VER=4.1.8/gcc11.4.0-cuda12.8.1
#PBS -v OMP_NUM_THREADS=48

#------- Program execution -----------
module load cuda/12.8.1
module load ucx/1.18.0/cuda12.8.1
module load openmpi/4.1.8/gcc11.4.0-cuda12.8.1
cd $PBS_O_WORKDIR
mpirun ${NQSV_MPIOPTS} -np 4 -npernode 1 --bind-to none -x UCX_RNDV_SCHEME=get_zcopy ../src-cuda-mpi/3drism-cuda-mpi test2.inp
