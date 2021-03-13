#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=2:30:00
#SBATCH --exclusive
#SBATCH --output test-pgi_2019_openmpi_O.bat_%j.o
export JOBID=$SLURM_JOBID
module load pgi/2019 openmpi/4.0.2 netcdf/4.7.4
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_F90COMPILER=mpif90
export ESMF_CXXCOMPILER=mpicxx
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/pgi_2019_openmpi_O
export ESMF_COMPILER=pgi
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make install 2>&1|tee install_$JOBID.log 
make all_tests 2>&1|tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1|tee ../nuopc_$JOBID.log 

