#!/bin/bash -l
#SBATCH --account=da-cpu
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output test-intel_2020_intelmpi_g.bat_%j.o
export JOBID=$SLURM_JOBID
module load intel/2020.2 impi/2020.2 netcdf/4.7.4
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/work/noaa/da/mpotts/sandbox/intel_2020_intelmpi_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 

export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 


cd ../src/addon/ESMPy

export PATH=$PATH:$HOME/.local/bin
python3 setup.py build 2>&1 | tee python_build.log
ssh Orion-login-1.HPC.MsState.Edu "export PATH=$PATH:$HOME/.local/bin;module load python/3.6.8;cd $PWD; python3 setup.py test_examples_dryrun"
ssh Orion-login-1.HPC.MsState.Edu "export PATH=$PATH:$HOME/.local/bin;module load python/3.6.8;cd $PWD; python3 setup.py test_regrid_from_file_dryrun"
ssh Orion-login-1.HPC.MsState.Edu "export PATH=$PATH:$HOME/.local/bin;module load python/3.6.8;cd $PWD; python3 setup.py test_regrid_from_file_dryrun"
python3 setup.py test 2>&1 | tee python_test.log
python3 setup.py test_examples 2>&1 | tee python_examples.log
python3 setup.py test_regrid_from_file 2>&1 | tee python_regrid.log
