#!/bin/bash -l
#SBATCH --account=s2326
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --time=1:00:00
#SBATCH --exclusive
#SBATCH --output test-intel_2020_intelmpi_g.bat_%j.o
export JOBID=$SLURM_JOBID
module load comp/intel/19.1.3.304 mpi/impi/19.1.3.304 netcdf4/4.7.4
module load hdf5/1.13.0 
module list
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5"
export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/intel_2020_intelmpi_g_develop
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

