#!/bin/bash -l
#PBS -N test-pgi_20.4_mpiuni_g.bat
#PBS -j oe
#PBS -q regular
#PBS -A p48503002
#PBS -l select=1:ncpus=36:mpiprocs=36
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/mpotts/pgi_20.4_mpiuni_g
set -x
module load pgi/20.4  netcdf/4.7.3
module list >& module-test.log

export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/mpotts/pgi_20.4_mpiuni_g
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

