#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2


vcftools --vcf ../data/88ind_maxmiss0.9_maf0.05.recode.vcf --plink --out ../data/88ind_maxmiss0.9_maf0.05
