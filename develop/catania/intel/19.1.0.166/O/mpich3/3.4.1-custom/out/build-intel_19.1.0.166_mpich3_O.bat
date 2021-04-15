#!/bin/bash -l
export JOBID=$1

module use /project/esmf/stack/modulefiles
module load intel/19.1.0.166/compiler intel/19.1.0.166/mpich3/3.4.1-custom 

module list >& module-build.log

set -x

export ESMF_MOAB=OFF
export ESMF_DIR=/Volumes/esmf/mpotts/intel_19.1.0.166_mpich3_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpich3
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 clean 2>&1| tee clean_$JOBID.log 
make -j 4 2>&1| tee build_$JOBID.log

