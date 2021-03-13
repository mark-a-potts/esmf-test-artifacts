#!/bin/bash -l
#PBS -N build-gfortran_10.1.0_mpt_O.bat
#PBS -j oe
#PBS -q regular
#PBS -A p48503002
#PBS -l select=1:ncpus=36:mpiprocs=36
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/mpotts/gfortran_10.1.0_mpt_O
set -x
module load gnu/10.1.0 mpt/2.23 netcdf/4.7.4
module list >& module-build.log

export ESMF_NETCDF=nc-config

export ESMF_F90COMPILEOPTS="-fallow-argument-mismatch -fallow-invalid-boz"
export ESMF_DIR=/glade/scratch/mpotts/gfortran_10.1.0_mpt_O
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpt
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 clean 2>&1|tee clean_$JOBID.log 
make -j 36 2>&1|tee build_$JOBID.log

