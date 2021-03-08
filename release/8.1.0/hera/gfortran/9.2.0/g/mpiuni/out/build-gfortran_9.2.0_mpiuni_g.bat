#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output build-gfortran_9.2.0_mpiuni_g.bat_%j.o
export JOBID=$SLURM_JOBID
set -x
module load gnu/9.2.0  netcdf/4.7.2
module list
export ESMF_NETCDF=nc-config
module load hdf5/1.10.5 
module list
export ESMF_NETCDF=split
export ESMF_NETCDF_INCLUDE=$NETCDF/include
export ESMF_NETCDF_LIBPATH=$NETCDF/lib
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5 $HDF5ExtraLibs"
export ESMF_NETCDF=nc-config
export ESMF_DIR=/scratch1/NCEPDEV/da/Mark.Potts/sandbox/gfortran_9.2.0_mpiuni_g
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean |& tee clean_$JOBID.log 
make -j 40 |& tee build_$JOBID.log

