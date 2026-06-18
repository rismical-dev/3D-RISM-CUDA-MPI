CC 	= mpic++

CFLAGS 	= -O3 
#CFLAGS 	= -O3 -fomit-frame-pointer -fopenmp

NVCC	= nvcc

#NVFLAGS = -O3 -m64 -gencode=arch=compute_90,code=sm_90 -I$(CUDA_DIR)/include -DTEST -DMVAPICH -DGDR
NVFLAGS = -O3 -m64 -gencode=arch=compute_90,code=sm_90 -I$(CUDA_DIR)/include -DTEST -DOPENMPI -DGDR

#LDFLAGS = -L$(CUDA_DIR)/lib64 
LIBS = -lcuda -lcudart -lcufft

OBJS   	= main.o\
	  alloc2D.o\
	  alloc3D.o\
	  anderson.o\
	  anderson_cuda.o\
	  cal_ad1.o\
	  cal_ad2.o\
	  cal_Coulomb.o\
	  cal_euv.o\
	  cal_exchem.o\
	  cal_grad.o\
	  cal_LJ.o\
	  cal_pmv.o\
	  cal_potential.o\
	  cal_pressure.o\
          cal_rms.o\
	  calculate.o\
	  calculate_cuda.o\
	  calloc2D.o\
	  cell.o\
	  control.o\
	  dealloc2D.o\
	  dealloc3D.o\
	  factor.o\
	  fft3d.o\
	  fft3d_cuda.o\
	  initialize.o\
	  initialize_g.o\
	  initialize_tuv.o\
	  iterate.o\
	  output.o\
	  output_ad.o\
	  output_cuv.o\
	  output_euv.o\
	  output_grad.o\
	  output_guv.o\
	  output_huv.o\
	  output_xmu.o\
	  read_input.o\
	  read_tuv.o\
	  set_ad.o\
	  set_cuda.o\
	  set_device.o\
	  set_fname.o\
	  set_mpi.o\
	  set_solvent.o\
	  solute.o\
	  solvent_read.o\
	  solvent_setup_mpi.o\
	  solvent_spline.o\
	  spline.o\
	  splint.o\
	  write_tuv.o\

PROGRAM = 3drism-cuda-mpi

all:	$(PROGRAM)

$(PROGRAM) : $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) $(LIBS) -o $(PROGRAM)

%.o: %.cc
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.cu
	$(NVCC) $(NVFLAGS) -c $< -o $@

clean:;	@rm -f $(OBJS) core

$(OBJS) : 
