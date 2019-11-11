# Reyes Galindo Verónica
# 12 Febrero 2019

### This script delete a SNPs in the same loci 

## Load libraries
library(readr)
library(dplyr)
library(tidyr)

## Load file with frequences calculated with vcfTools --freq 
frecAreligiosa<- read.delim("../../data/freq_88ind_maxmiss0.9_maf0.05.frq")
head(frecAreligiosa)

# Identify duplicates and keep them all (not only the first as duplicate() alone does )
duplicated.loci<-frecAreligiosa[duplicated(frecAreligiosa$CHROM) | duplicated(frecAreligiosa$CHROM, fromLast = TRUE),]
head(duplicated.loci)


# keep the locus with higherst: Freq1
duplicated.loci$Fre1<-readr::parse_number(duplicated.loci$Fre1) # keep only numbers
selected.loci<- duplicated.loci[order(duplicated.loci[,"CHROM"], -duplicated.loci[ ,"Fre1"]), ] # make sure highest freq is first
selected.loci<- duplicated.loci[!duplicated(duplicated.loci$CHROM), ] # remove duplicates (keeps only the first, that is the one with  the highest Fre1)
head(selected.loci)

# Create list with selected loci + loci with a single SNP per locus
x<-frecAreligiosa[!(frecAreligiosa$CHROM %in% selected.loci$CHROM), ]
x$Fre1<-readr::parse_number(x$Fre1)
selected.loci<- rbind(x, selected.loci)
head(selected.loci)
tail(selected.loci)

# Order data accord id loci
dataorder<-selected.loci[order(match(selected.loci$CHROM, frecAreligiosa$CHROM)), ]

# Select data to export
data_exportAr<-as.data.frame(dataorder[1:2])

#Export in list
write.table(data_exportAr, file = "../metadata/positions_s88_Ar0.9.txt", quote = FALSE,
            row.names = FALSE, col.names = FALSE)


