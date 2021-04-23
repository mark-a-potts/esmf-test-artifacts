#!/bin/bash -l
#PBS -N test-nag_7.0_mpich_O.bat
#PBS -j oe
#PBS -q medium
#PBS -A P93300606
#PBS -l select=1:ncpus=15:mpiprocs=15
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/mpotts/nag_7.0_mpich_O
module load compiler/nag/7.0 mpi/2.3.3/gnu/7.0 tool/netcdf/c4.7.4-f4.5.2/nag-gnu/7.0-9.3.0
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/mpotts/nag_7.0_mpich_O
export ESMF_COMPILER=nag
export ESMF_COMM=mpich
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

ssh izumi.unified.ucar.edu /scratch/cluster/mpotts/nag_7.0_mpich_O/getres-test.sh

