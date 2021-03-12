#!/bin/bash -l
#PBS -N test-gfortran_9.2.0_openmpi_g.bat
#PBS -j oe
#PBS -q standard
#PBS -A NRLMR03795024
#PBS -l select=1:ncpus=48:mpiprocs=48
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /p/work1/mpotts/gfortran_9.2.0_openmpi_g

module load cseinit
module load gcc/9.2.0 compiler/openmpi/2.1.2 

module list >& module-test.log

set -x

export ESMF_DIR=/p/work1/mpotts/gfortran_9.2.0_openmpi_g
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

ssh gaffney06 /p/work1/mpotts/gfortran_9.2.0_openmpi_g/getres-test.sh

