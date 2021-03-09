#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=2:00:00
#SBATCH --exclusive
#SBATCH --output build-pgi_2019_openmpi_O.bat_%j.o
export JOBID=$SLURM_JOBID
set -x
module load pgi/2019 openmpi/4.0.2 netcdf/4.7.4
module list >& module-build.log

export ESMF_NETCDF=nc-config

export ESMF_F90COMPILER=mpif90
export ESMF_CXXCOMPILER=mpicxx
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_O
export ESMF_COMPILER=pgi
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1|tee clean_$JOBID.log 
make -j 40 2>&1|tee build_$JOBID.log

