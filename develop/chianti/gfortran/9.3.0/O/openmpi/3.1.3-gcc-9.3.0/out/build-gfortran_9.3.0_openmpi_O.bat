#!/bin/bash -l
export JOBID=$1

module use /home/mpotts/spack/share/spack/modules/linux-linuxmint19-skylake

module load python
module load gcc/9.3.0-gcc-7.5.0 openmpi/3.1.3-gcc-9.3.0 netcdf-c/4.7.4-gcc-9.3.0-openmpi
module load hdf5/1.10.7-gcc-9.3.0-openmpi 
module list
module load netcdf-fortran/4.5.3-gcc-9.3.0-openmpi 
module list
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export ESMF_DIR=/home/mpotts/gfortran_9.3.0_openmpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 8 clean 2>&1| tee clean_$JOBID.log 
make -j 8 2>&1| tee build_$JOBID.log

