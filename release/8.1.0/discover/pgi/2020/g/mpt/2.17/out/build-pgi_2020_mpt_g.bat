#!/bin/bash -l
#SBATCH --account=s2326
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output build-pgi_2020_mpt_g.bat_%j.o
export JOBID=$SLURM_JOBID
set -x
module load comp/pgi/20.4 mpi/sgi-mpt/2.17 
module list >& module-build.log
module list >& module-build.log

export -n ESMF_NETCDF

export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/pgi_2020_mpt_g
export ESMF_COMPILER=pgi
export ESMF_COMM=mpt
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 clean 2>&1|tee clean_$JOBID.log 
make -j 28 2>&1|tee build_$JOBID.log

