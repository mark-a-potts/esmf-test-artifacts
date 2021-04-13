#!/bin/bash -l
#PBS -N build-pgi_20.1_mpich_g.bat
#PBS -j oe
#PBS -q medium
#PBS -A P93300606
#PBS -l select=1:ncpus=15:mpiprocs=15
#PBS -l walltime=1:00:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/mpotts/pgi_20.1_mpich_g
module load compiler/pgi/20.1 mpi/2.3.3/pgi/20.1 tool/netcdf/4.7.4/pgi/20.1
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/mpotts/pgi_20.1_mpich_g
export ESMF_COMPILER=pgi
export ESMF_COMM=mpich
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 15 clean 2>&1| tee clean_$JOBID.log 
make -j 15 2>&1| tee build_$JOBID.log

ssh izumi.unified.ucar.edu /scratch/cluster/mpotts/pgi_20.1_mpich_g/getres-build.sh

