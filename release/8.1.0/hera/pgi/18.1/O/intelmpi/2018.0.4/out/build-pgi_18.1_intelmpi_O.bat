#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=2:00:00
#SBATCH --exclusive
#SBATCH --output build-pgi_18.1_intelmpi_O.bat_%j.o
export JOBID=$SLURM_JOBID
set -x
module load hdf5/1.10.5 
module list
module list >& module-build.log



export ESMF_DIR=/scratch1/NCEPDEV/da/Mark.Potts/sandbox/pgi_18.1_intelmpi_O
export ESMF_COMPILER=pgi
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1|tee clean_$JOBID.log 
make -j 40 2>&1|tee build_$JOBID.log

