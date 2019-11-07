# 19-Sept-2019
# Calculate Heterosigosity
# Reyes Galindo Verónica

###################################################################
# Before you need calculate heterozygosity with VCFTools
# vcftools --vcf input.vcf --keep samples_name.txt --het --out output.het
# The output of the --het function is a summary for each individual of the observed number of homozygous sites ( O(hom) ) and the expected number of homozygous sites ( E(hom) ). It also includes the total number of sites that the individual has data for and the inbreeding coefficient F.
###################################################################


# Load file ".het"
file<- read.delim("../../data/samples_het_snp_withoutDupLoci_10ind_maxmiss0.9_maf0.05.het")

# Calculate HeO y HeE

file$HeO<- file$N_SITES-file$O.HOM.
file$HeE<- file$N_SITES-file$E.HOM.

# Proportion of HeO y HeE

file$PrHeO<-file$O.HOM./file$N_SITES
file$PrHeE<-file$E.HOM./file$N_SITES

# Give categories

file$condition<- c("healthy", "healthy", "healthy", "healthy", "healthy",
                   "damaged", "damaged", "damaged", "damaged", "damaged" )


# Calculate significance 


pairwise.t.test(file$PrHeO, file$condition)





