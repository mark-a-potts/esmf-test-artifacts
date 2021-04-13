#!/usr/local/bin/bash -l
export JOBID=$1
module load gcc 3.1.5 netcdf-c/4.7.3
module load netcdf-fortran/4.5.2 
module list
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export CC=/usr/local/bin/gcc-9
export CXX=/usr/local/bin/g++-9
export FC=/usr/local/bin/gfortran-9
export ESMF_CXXLINKPATHS="-L$HDF5_ROOT/lib $HDF5LDFLAGS -lz"
export ESMF_F90COMPILER=$FC
export ESMF_F90LINKER=mpif90
export ESMF_F90LINKPATHS="-L$HDF5_ROOT/lib $HDF5LDFLAGS -lz"
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5 $HDF5ExtraLibs -lz"
export ESMF_DIR=/Users/mpotts/gfortran_9.3.0_openmpi_O
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 clean 2>&1| tee clean_$JOBID.log 
make -j 4 2>&1| tee build_$JOBID.log

