#!/bin/bash -l
#PBS -N build-intel_2017.5_mpi_g.bat
#PBS -j oe
#PBS -q standard
#PBS -A NRLMR03795024
#PBS -l select=1:ncpus=44:mpiprocs=44
#PBS -l walltime=0:05:00
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /p/work/mpotts/intel_2017.5_mpi_g

ssh onyx08 /p/work/mpotts/intel_2017.5_mpi_g/getres-build.sh |& tee ssh.log

