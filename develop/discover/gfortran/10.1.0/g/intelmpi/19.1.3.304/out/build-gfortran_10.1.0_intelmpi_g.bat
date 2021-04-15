#!/bin/bash -l
#SBATCH --account=s2326
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output build-gfortran_10.1.0_intelmpi_g.bat_%j.o
export JOBID=$SLURM_JOBID
module load comp/gcc/10.1.0 mpi/impi/19.1.3.304 

module list >& module-build.log

set -x

export ESMF_F90COMPILEOPTS="-fallow-argument-mismatch -fallow-invalid-boz"
export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/gfortran_10.1.0_intelmpi_g_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 clean 2>&1| tee clean_$JOBID.log 
make -j 28 2>&1| tee build_$JOBID.log

