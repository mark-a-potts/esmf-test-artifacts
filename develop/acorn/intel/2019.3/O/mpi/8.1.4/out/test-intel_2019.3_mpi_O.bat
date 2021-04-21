#!/bin/sh -l
#PBS -N test-intel_2019.3_mpi_O.bat
#PBS -l walltime=1:00:00
#PBS -q workq
#PBS -A emc
#PBS -l select=1:ncpus=128:mpiprocs=128
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /lfs/h1/emc/nceplibs/noscrub/Mark.Potts/esmf-test-scripts/intel_2019.3_mpi_O_develop

module unload PrgEnv-cray PrgEnv-gnu

module load PrgEnv-intel cray-pals
module load intel/19.1.3.304 cray-mpich/8.1.4 cray-netcdf/4.7.4.3
module load cray-hdf5/1.12.0.3 
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_OS=Linux
export ESMF_CXXCOMPILER=CC
export ESMF_F90COMPILER=ftn
export ESMF_CXXLINKER=CC
export ESMF_F90LINKER=ftn
export ESMF_MPIRUN=mpirun.unicos
export ESMF_CXXCOMPILECPPFLAGS=-fPIC
export ESMF_CXXLINKOPTS="-fPIC -lnetcdff -lnetcdff"
export ESMF_NETCDF=$PWD/nc-config
sed -i 's/^aprun/mpiexec/' scripts/mpirun.unicos
sed -i 's/lmpi++/lfmpich/' build_config/Linux.intel.default/build_rules.mk
export ESMF_DIR=/lfs/h1/emc/nceplibs/noscrub/Mark.Potts/esmf-test-scripts/intel_2019.3_mpi_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
ssh alogin01 /lfs/h1/emc/nceplibs/noscrub/Mark.Potts/esmf-test-scripts/intel_2019.3_mpi_O_develop/getres-test.sh
