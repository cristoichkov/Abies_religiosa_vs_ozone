#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2

vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --he --out samples_he_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05
