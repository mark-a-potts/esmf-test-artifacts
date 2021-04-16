#!/bin/bash -l
export JOBID=12346

module use /home/mpotts/spack/share/spack/modules/linux-linuxmint19-skylake

module load python
module load gcc/9.3.0-gcc-7.5.0 openmpi/3.1.3-gcc-9.3.0 netcdf-c/4.7.4-gcc-9.3.0-openmpi
module load hdf5/1.10.7-gcc-9.3.0-openmpi 
module load netcdf-fortran/4.5.3-gcc-9.3.0-openmpi 
set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export ESMF_DIR=/home/mpotts/gfortran_9.3.0_openmpi_O_patch_8.1.1
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
chmod +x runpython.sh
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 


cd ../src/addon/ESMPy

export PATH=$PATH:$HOME/.local/bin
python3 setup.py build 2>&1 | tee python_build.log
ssh chianti /home/mpotts/gfortran_9.3.0_openmpi_O_patch_8.1.1/runpython.sh 2>&1 | tee python_build.log
python3 setup.py test 2>&1 | tee python_test.log
python3 setup.py test_examples 2>&1 | tee python_examples.log
python3 setup.py test_regrid_from_file 2>&1 | tee python_regrid.log
