#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2

vcftools --vcf TMVB_5SNPradlocus.vcf --keep 89_ind.txt --max-missing 0.9 --maf 0.05 --recode --out 89ind_maxmiss0.9_maf0.05
