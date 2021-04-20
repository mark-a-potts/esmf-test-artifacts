#!/bin/bash -l
#PBS -N build-gfortran_9.2.0_openmpi_O.bat
#PBS -j oe
#PBS -q standard
#PBS -A NRLMR03795024
#PBS -l select=1:ncpus=48:mpiprocs=48
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /p/work1/mpotts/gfortran_9.2.0_openmpi_O_develop

module load cseinit
module load gcc/9.2.0 compiler/openmpi/2.1.2 

module list >& module-build.log

set -x

export ESMF_DIR=/p/work1/mpotts/gfortran_9.2.0_openmpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 48 clean 2>&1| tee clean_$JOBID.log 
make -j 48 2>&1| tee build_$JOBID.log

ssh gaffney06 /p/work1/mpotts/gfortran_9.2.0_openmpi_O_develop/getres-build.sh

