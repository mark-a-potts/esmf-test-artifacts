#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output build-intel_2020_intelmpi_O.bat_%j.o
export JOBID=$SLURM_JOBID
module load intel/2020.2 impi/2020.2 netcdf/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/work/noaa/da/mpotts/sandbox/intel_2020_intelmpi_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1| tee clean_$JOBID.log 
make -j 40 2>&1| tee build_$JOBID.log

