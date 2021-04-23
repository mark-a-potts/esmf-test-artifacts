#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o build-pgi_18.1_intelmpi_g.bat_%j.o
#SBATCH -e build-pgi_18.1_intelmpi_g.bat_%j.e
#SBATCH --time=1:20:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
export ESMF_MPIRUN=mpirun.srun
module load pgi/18.10 impi/2018.0.4 

module list >& module-build.log

set -x

export ESMF_DIR=/scratch1/NCEPDEV/stmp2/Mark.Potts/pgi_18.1_intelmpi_g_develop
export ESMF_COMPILER=pgi
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 clean 2>&1| tee clean_$JOBID.log 
make -j 40 2>&1| tee build_$JOBID.log

