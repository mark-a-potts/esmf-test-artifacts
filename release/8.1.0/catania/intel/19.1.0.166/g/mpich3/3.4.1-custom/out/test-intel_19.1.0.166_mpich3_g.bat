#!/bin/bash -l
export JOBID=$1

module use /project/esmf/stack/modulefiles
module load intel/19.1.0.166/compiler intel/19.1.0.166/mpich3/3.4.1-custom 

module list >& module-test.log

set -x

export ESMF_MOAB=OFF
export ESMF_DIR=/Volumes/esmf/rocky/et/intel_19.1.0.166_mpich3_g
export ESMF_COMPILER=intel
export ESMF_COMM=mpich3
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

