#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=2:30:00
#SBATCH --exclusive
#SBATCH --output test-pgi_18.1_intelmpi_O.bat_%j.o
export JOBID=$SLURM_JOBID
set -x
module load hdf5/1.10.5 
module list
module list >& module-test.log



export ESMF_DIR=/scratch1/NCEPDEV/da/Mark.Potts/sandbox/pgi_18.1_intelmpi_O
export ESMF_COMPILER=pgi
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

