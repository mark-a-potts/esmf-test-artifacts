#!/usr/local/bin/bash -l
export JOBID=$1
module load gcc 3.1.5 netcdf-c/4.7.3
module load hdf5/1.10.6 
module list
module load netcdf-fortran/4.5.2 
module list
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export ESMF_F90COMPILER=mpif90
export ESMF_F90LINKER=mpif90
export ESMF_DIR=/Users/mpotts/gfortran_9.3.0_openmpi_g
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 clean 2>&1| tee clean_$JOBID.log 
make -j 4 2>&1| tee build_$JOBID.log

