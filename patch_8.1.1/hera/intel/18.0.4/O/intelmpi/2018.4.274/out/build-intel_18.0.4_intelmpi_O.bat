#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o build-intel_18.0.4_intelmpi_O.bat_%j.o
#SBATCH -e build-intel_18.0.4_intelmpi_O.bat_%j.e
#SBATCH --time=1:20:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load intel/18.0.5.274 impi/2018.4.274 netcdf/4.7.0
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch1/NCEPDEV/da/Mark.Potts/sandbox/intel_18.0.4_intelmpi_O_patch_8.1.1
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1| tee clean_$JOBID.log 
make -j 40 2>&1| tee build_$JOBID.log

