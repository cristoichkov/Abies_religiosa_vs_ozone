#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2

export LD_LIBRARY_PATH=/opt/miniconda2/lib
export HDF5_USE_FILE_LOCKING=FALSE

ipyrad -p .vcf -s 1234567 -f