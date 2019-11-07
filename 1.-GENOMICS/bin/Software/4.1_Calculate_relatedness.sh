#! /bin/sh

#SBATCH -p keri
#SBATCH --mem 80000
#SBATCH -n 2

./plink --bfile snp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --make-rel square --make-bed --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --bfile relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --file relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode vcf --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
