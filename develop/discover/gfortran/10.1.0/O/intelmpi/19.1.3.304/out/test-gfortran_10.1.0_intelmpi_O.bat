#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o test-gfortran_10.1.0_intelmpi_O.bat_%j.o
#SBATCH -e test-gfortran_10.1.0_intelmpi_O.bat_%j.e
#SBATCH --time=1:20:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load comp/gcc/10.1.0 mpi/impi/19.1.3.304 

module list >& module-test.log

set -x

export ESMF_F90COMPILEOPTS="-fallow-argument-mismatch -fallow-invalid-boz"
export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/gfortran_10.1.0_intelmpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
