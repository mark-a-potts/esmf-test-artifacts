#!/usr/local/bin/bash -l
export JOBID=$1
module load None 3.3.1 

module list >& module-build.log

set -x

export ESMF_NETCDF=/Users/mpotts/stack-mods-47/bin/nc-config
export ESMF_NFCONFIG=/Users/mpotts/stack-mods-47/bin/nf-config
export CC=/usr/local/bin/gcc-9
export CXX=/usr/local/bin/g++-9
export FC=/usr/local/bin/gfortran-9
export PATH=/Users/mpotts/stack-mods-47/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/Users/mpotts/stack-mods-47/lib
export LIBRARY_PATH=$LIBRARY_PATH:/Users/mpotts/stack-mods-47/lib
export MPICH_CC=$CC
export MPICH_CXX=$CXX
export NETCDF_ROOT=/Users/mpotts/stack-mods-47
export HDF5_ROOT=/Users/mpotts/stack-mods-47
export ESMF_CXXLINKPATHS="-L$HDF5_ROOT/lib $HDF5LDFLAGS -lz"
export ESMF_F90COMPILER=$FC
export ESMF_F90LINKER=mpif90
export ESMF_F90LINKPATHS="-L$HDF5_ROOT/lib $HDF5LDFLAGS -lz"
export ESMF_NETCDF=split
export ESMF_NETCDF_INCLUDE=$NETCDF_ROOT/include
export ESMF_NETCDF_LIBPATH=$NETCDF_ROOT/lib
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5 $HDF5ExtraLibs -lz"
export ESMF_DIR=/Users/mpotts/gfortran_9.3.0_mpich3_O
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpich3
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 clean 2>&1|tee clean_$JOBID.log 
make -j 4 2>&1|tee build_$JOBID.log

