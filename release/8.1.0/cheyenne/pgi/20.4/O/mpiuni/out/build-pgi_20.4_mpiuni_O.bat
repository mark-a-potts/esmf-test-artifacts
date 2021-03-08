#!/bin/bash -l
#PBS -N build-pgi_20.4_mpiuni_O.bat
#PBS -j oe
#PBS -q regular
#PBS -A p48503002
#PBS -l select=1:ncpus=36:mpiprocs=36
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/mpotts/pgi_20.4_mpiuni_O
set -x
export ESMF_MPIRUN=/glade/scratch/mpotts/pgi_20.4_mpiuni_O/src/Infrastructure/stubs/mpiuni/mpirun
module load pgi/20.4  netcdf/4.7.3
module list >& module-build.log

export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/mpotts/pgi_20.4_mpiuni_O
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 clean 2>&1|tee clean_$JOBID.log 
make -j 36 2>&1|tee build_$JOBID.log

