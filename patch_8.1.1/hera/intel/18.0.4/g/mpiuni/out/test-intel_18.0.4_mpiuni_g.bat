#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output test-intel_18.0.4_mpiuni_g.bat_%j.o
export JOBID=$SLURM_JOBID
module load intel/18.0.5.274  netcdf/4.7.0
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch1/NCEPDEV/da/Mark.Potts/sandbox/intel_18.0.4_mpiuni_g_patch_8.1.1
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

