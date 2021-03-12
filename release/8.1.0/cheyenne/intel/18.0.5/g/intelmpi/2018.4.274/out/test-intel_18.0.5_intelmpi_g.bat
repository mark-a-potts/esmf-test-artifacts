#!/bin/bash -l
#PBS -N test-intel_18.0.5_intelmpi_g.bat
#PBS -j oe
#PBS -q regular
#PBS -A p48503002
#PBS -l select=1:ncpus=36:mpiprocs=36
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/mpotts/intel_18.0.5_intelmpi_g
module load intel/18.0.5 impi/2018.4.274 netcdf/4.6.3
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/mpotts/intel_18.0.5_intelmpi_g
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

ssh cheyenne6 /glade/scratch/mpotts/intel_18.0.5_intelmpi_g/getres-test.sh

