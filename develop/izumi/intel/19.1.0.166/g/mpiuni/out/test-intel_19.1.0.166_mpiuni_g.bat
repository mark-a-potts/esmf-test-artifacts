#!/bin/bash -l
#PBS -N test-intel_19.1.0.166_mpiuni_g.bat
#PBS -j oe
#PBS -q medium
#PBS -A P93300606
#PBS -l select=1:ncpus=15:mpiprocs=15
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/mpotts/intel_19.1.0.166_mpiuni_g
module load compiler/intel/20.0.1  tool/netcdf/4.7.4/intel/20.0.1
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/mpotts/intel_19.1.0.166_mpiuni_g
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

ssh izumi.unified.ucar.edu /scratch/cluster/mpotts/intel_19.1.0.166_mpiuni_g/getres-test.sh

