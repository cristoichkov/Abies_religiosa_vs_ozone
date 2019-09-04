# Reyes Galindo Ver??nica
# 8 Octubre 2018

#######################################################
#    ELIMINAR MUESTRAS CON MISSING DATA MAYOR A 0.8
#######################################################
# En el contenedor en Docker para vcftools:
# vcftools --vcf archivo.vcf --missing-indv --out archivo_nuevo
# Outfiles *.imiss y *.log

### TabMD= Tabla de datos del archivo "*.imiss"
### Bad_TabMD*= Datos que por sus valores > 0.8 no deben considerarse para el analisis
#                              OUTFILES
#*.txt

###########################################
# Abrir el archivo con terminacion ".imiss"
###########################################

TabMD90_90samples <- read.table("90ind_maxmiss0.9_maf0.05.imiss", header = T) 
TabMD90_99samples <- read.table("99ind_maxmiss0.9_maf0.05.imiss", header = T) 
TabMD90_103samples <- read.table("103ind_maxmiss0.9_maf0.05.imiss", header = T) 
TabMD90_107samples <- read.table("107ind_maxmiss0.9_maf0.05.imiss", header = T) 
TabMD90_88samples <- read.table("88ind_maxmiss0.9_maf0.05.imiss", header = T) 



############################################################
#   Extraer muestras mayores a 0.8 y exportarlas en un .txt 
############################################################
library(dplyr) 
library(plyr)
library (tidyr)

for (i in c ("TabMD90_90samples","TabMD90_99samples", "TabMD90_103samples","TabMD90_107samples, TabMD90_88samples")){
  x<-get(i)
  r<-x$F_MISS > 0.2
  Bad_TabMD<-x[r,1]
  write.table(Bad_TabMD, file = paste0(i,".txt"), row.names = FALSE, col.names=FALSE, quote = FALSE) 
}

#################################################
#   Contar missing data y muestras eliminadas
#################################################

missdatall_90_90samples <-sum(TabMD90_90samples$N_DATA)-sum(TabMD90_90samples$N_MISS)
missdatall_90_90samples
missdatall_90_99samples <-sum(TabMD90_99samples$N_DATA)-sum(TabMD90_99samples$N_MISS)
missdatall_90_99samples
missdatall_90_103samples <-sum(TabMD90_103samples$N_DATA)-sum(TabMD90_103samples$N_MISS)
missdatall_90_103samples
missdatall_90_107samples <-sum(TabMD90_107samples$N_DATA)-sum(TabMD90_107samples$N_MISS)
missdatall_90_107samples
missdatall_90_88samples <-sum(TabMD90_88samples$N_DATA)-sum(TabMD90_88samples$N_MISS)
missdatall_90_88samples


############################################################
#   Extraer informacion
############################################################

sum(TabMD90_90samples$N_DATA)
sum(TabMD90_90samples$N_MISS)

sum(TabMD90_99samples$N_DATA)
sum(TabMD90_99samples$N_MISS)

sum(TabMD90_103samples$N_DATA)
sum(TabMD90_103samples$N_MISS)

sum(TabMD90_107samples$N_DATA)
sum(TabMD90_107samples$N_MISS)

sum(TabMD90_88samples$N_DATA)
sum(TabMD90_88samples$N_MISS)



