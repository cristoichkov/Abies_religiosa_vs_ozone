# Reyes Galindo Verónica
# 12 Febrero 2019

### This script draw a plot with eigenvects values using SNPRelate


## Load packages
library(gdsfmt)
library(SNPRelate)
library(ggplot2)

#Load data file (".vcf")
vcf.fn <- "../../data/without_Dup_loci/snp_withoutDupLoci_88s_maxmiss0.9_maf0.05.vcf"

## Reformat to ".gds" file
snpgdsVCF2GDS(vcf.fn, "../../outputs/snp_withoutDupLoci_88s_maxmiss0.9_maf0.05_pca.gds", method="biallelic.only", verbose = TRUE)

## Get summary ".gds" file
snpgdsSummary("../../outputs/snp_withoutDupLoci_88s_maxmiss0.9_maf0.05_pca.gds")

## Open ".gds" file
genofile <- snpgdsOpen("../../outputs/snp_withoutDupLoci_88s_maxmiss0.9_maf0.05_pca.gds")

## Run PCA
pca<-snpgdsPCA(genofile,remove.monosnp=TRUE, num.thread=2)

## Get variance proportion (%)
pc.percent <- pca$varprop*100
head(round(pc.percent, 2))

## Make a data.frame with eigenvects values
tab <- data.frame(sample.id = pca$sample.id, EV1 = pca$eigenvect[,1],    # the first eigenvector,
                  EV2 = pca$eigenvect[,2],    # the second eigenvector
                  stringsAsFactors = FALSE)

## Load metadata file
fullmat<-read.csv("../../metadata/PLACA_FINAL_89_samples.csv", header = TRUE, sep = ",")

## Match metadata info with eigenvectors values
tab$Poblacion<-fullmat$Localidad[match(tab$sample.id, fullmat$key_comun)]

## Choose nice colors and ozone condition
pobcol<- c( "#e94b57",
            "#000000",
            "#76c74f")
tab$Condicion<- c("otro","otro","otro","otro",
                  "otro","otro","otro",
                  "dañada","dañada","dañada","dañada",
                  "sana","sana","sana","sana","sana",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro","otro","otro","otro","otro","otro","otro","otro","otro",
                  "otro","otro")

## Draw PCA with ozone condition
ggplot(tab, aes(x=EV1, y=EV2))+
  geom_point(aes(color=Condicion, shape=Poblacion), size =5) +
  scale_color_manual(values = pobcol) +
  theme(legend.title = element_text(size=15))+
  theme(legend.text = element_text(size = 15))+
  xlab(paste0("Eigenvector 1 explicando ", round(pc.percent, 2)[1], "%")) +
  ylab(paste0("Eigenvector 2 explicando ", round(pc.percent, 2)[2], "%"))+
  theme(axis.title.y = element_text(size = rel(2), angle = 90))+
  theme(axis.title.x = element_text(size = rel(2), angle = 360))+
  theme(axis.text.x = element_text(hjust = .5, size=13, color="black"))+
  theme(axis.text.y = element_text(hjust = .5, size=13, color="black"))+
  geom_point(alpha = 1/20)+
  scale_shape_manual(values=c(0,1,2,3,4,5,6,7,8,11,13,15,16,17,18,35,38,43,64))

ggsave("../../outputs/6.1_PCA.png")

## Draw a zoom with same values of PCA with ozone condition
tab2<- tab[-c(1:3,21:25,41:43,44:47,48:50,51:55,71:74,84:88), ]
ggplot(tab2, aes(x=EV1, y=EV2))+
  geom_point(aes(color=Condicion, shape=Poblacion), size =5) +
  scale_color_manual(values = pobcol) +
  theme(legend.title = element_text(size=15))+
  theme(legend.text = element_text(size = 15))+
  xlab(paste0("Eigenvector 1 explicando ", round(pc.percent, 2)[1], "%")) +
  ylab(paste0("Eigenvector 2 explicando ", round(pc.percent, 2)[2], "%"))+
  theme(axis.title.y = element_text(size = rel(2), angle = 90))+
  theme(axis.title.x = element_text(size = rel(2), angle = 360))+
  theme(axis.text.x = element_text(hjust = .5, size=13, color="black"))+
  theme(axis.text.y = element_text(hjust = .5, size=13, color="black"))+
  geom_point(alpha = 1/20)+
  scale_shape_manual(values=c(0,1,4,5,6,11,13,15,18,38,43))

## Draw with plate sequencing
tab$PLACA<-fullmat$PLACA[match(tab$sample.id, fullmat$key_comun)]
pobcol<- c(  "#FF00FF","#99CC33",  "#9999FF", "#33CCFF", "#0066FF", "#33CCFF","#9933FF", "#FF99FF", "#FF0000", "#FF9933", "#FFCC33", "#FF00FF", "#CC9900", "#666666", "#000000", "#FF7A12", "#FF42B3" )
ggplot(tab, aes(x=EV1, y=EV2))+
  geom_point(aes(color=PLACA), size =1) +
  scale_color_manual(values = pobcol) +
  theme(legend.title = element_text(size=13))+
  theme(legend.text = element_text(size = 12))+
  xlab(paste0("Eigenvector 1 explicando ", round(pc.percent, 2)[1], "%")) +
  ylab(paste0("Eigenvector 2 explicando ", round(pc.percent, 2)[2], "%"))+
  theme(axis.title.y = element_text(size = rel(1.5), angle = 90))+
  theme(axis.title.x = element_text(size = rel(1.5), angle = 360))+
  theme(axis.text.x = element_text(hjust = .5, size=13, color="black"))+
  theme(axis.text.y = element_text(hjust = .5, size=13, color="black"))+
  geom_point(alpha = 1/20)
