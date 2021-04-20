#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o build-gfortran_8.3.0_mpiuni_g.bat_%j.o
#SBATCH -e build-gfortran_8.3.0_mpiuni_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load gcc/8.3.0  netcdf/4.7.2
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export LD_PRELOAD=/apps/gcc-8/gcc-8.3.0/lib64/libstdc++.so
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/gfortran_8.3.0_mpiuni_g_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1| tee clean_$JOBID.log 
make -j 40 2>&1| tee build_$JOBID.log

