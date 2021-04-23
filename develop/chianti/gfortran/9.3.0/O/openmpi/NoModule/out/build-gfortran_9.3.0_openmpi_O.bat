#!/bin/bash -l
export JOBID=$1
module load None NoModule 

module list >& module-build.log

set -x

export ESMF_NETCDF=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-9.3.0/netcdf-c-4.7.4-mh42cmw5oougqeytguqxjkkrrd2bfdsl/bin/nc-config
export ESMF_NFCONFIG=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-9.3.0/netcdf-fortran-4.5.3-7cigsuiobyasv6mbext7pmabw5fhzo6y/bin/nf-config
export CC=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-7.5.0/gcc-9.3.0-3ltccu6cenbq/bin/gcc
export CXX=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-7.5.0/gcc-9.3.0-3ltccu6cenbq/bin/g++
export FC=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-7.5.0/gcc-9.3.0-3ltccu6cenbq/bin/gfortran
export ESMF_NFCONFIG=nf-config
export PATH=/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-9.3.0/openmpi-3.1.6-jnhkylwskoutgnisw5k4agyzw77xr35b/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-9.3.0/openmpi-3.1.6-jnhkylwskoutgnisw5k4agyzw77xr35b/lib
export LIBRARY_PATH=$LIBRARY_PATH:/home/mpotts/spack/opt/spack/linux-linuxmint19-skylake/gcc-9.3.0/openmpi-3.1.6-jnhkylwskoutgnisw5k4agyzw77xr35b/lib
export ESMF_DIR=/home/mpotts/gfortran_9.3.0_openmpi_O
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 8 clean 2>&1| tee clean_$JOBID.log 
make -j 8 2>&1| tee build_$JOBID.log

