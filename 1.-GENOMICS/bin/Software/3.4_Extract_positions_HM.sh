#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2

./plink --file 88ind_maxmiss0.9_maf0.05 --extract positions_s88_Ar0.9.txt  --make-bed --out snp_withoutDupLoci_88s_maxmiss0.9_maf0.05
