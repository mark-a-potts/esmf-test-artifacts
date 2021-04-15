#!/bin/bash -l
#SBATCH --account=s2326
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output build-gfortran_8.3.0_mpiuni_O.bat_%j.o
export JOBID=$SLURM_JOBID
export ESMF_MPIRUN=/gpfsm/dnb04/projects/p98/mpotts/esmf/gfortran_8.3.0_mpiuni_O_develop/src/Infrastructure/stubs/mpiuni/mpirun
module load comp/gcc/8.3.0  

module list >& module-build.log

set -x

export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/gfortran_8.3.0_mpiuni_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 clean 2>&1| tee clean_$JOBID.log 
make -j 28 2>&1| tee build_$JOBID.log

