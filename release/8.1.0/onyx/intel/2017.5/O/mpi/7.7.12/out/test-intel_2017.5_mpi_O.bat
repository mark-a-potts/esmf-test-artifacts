#!/bin/bash -l
#PBS -N test-intel_2017.5_mpi_O.bat
#PBS -j oe
#PBS -q standard
#PBS -A NRLMR03795024
#PBS -l select=1:ncpus=44:mpiprocs=44
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /p/work/mpotts/intel_2017.5_mpi_O

module unload PrgEnv-cray PrgEnv-gnu

module load PrgEnv-intel
export ESMF_F90COMPILER=ftn
module load intel/17.0.5.239 cray-mpich/7.7.12 netcdf/intel-17.0.1.132/4.4.1.1
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/p/work/mpotts/intel_2017.5_mpi_O
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1|tee ../nuopc_$JOBID.log 

