# DESeq2

library(DESeq2)
library(magrittr) # needs to be run every time you start R and want to use %>%
library(dplyr)  
library(ggplot2)
# Volver la data frame una matriz de datos
alldata<-read.delim("../../../../metadata/allreadsgenes.txt")
alldata <- as.data.frame(alldata)
x<-alldata
rownames(x)<-alldata[,1]
x<-x[ ,2:ncol(x)]
alldata<-as.matrix(x)

# Comparaciones
DC235vsDSS124<- subset(alldata, select = -c(HC_1, HC_2, HC_3, HC_4, HC_5, HS_1, HS_2, HS_5,
                                            HC17, DC47,
                                            DC_1,DC_4))

# Información sobre estos individuos
tratamiento <- c("DC", "DC", "DC",
                 "DS", "DS", "DS")
label<- c("DC_2", "DC_3", "DC_5",
          "DS_1", "DS_2","DS_4")
samples<- c("DC2", "DC3", "DC5",
            "DS1", "DS2","DS4")
colData<- data.frame(tratamiento,label,samples)
rownames(colData)<- label
description<- colData[,c("tratamiento", "samples")]

# Filtrado de genes. Retirar genes con ningun conteo 
matrizconteo <- DC235vsDSS124 
head(matrizconteo )
suma <- rowSums(matrizconteo)
matriznueva<- matrizconteo[suma != 0,] 
dim(matriznueva)
head(matriznueva)

# Creamos el objeto con la clase DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData=matriznueva, colData= description, design=~tratamiento)
dds$tratamiento
dds$tratamiento <- relevel(dds$tratamiento, "DS")
dds$tratamiento 

# Pruebas DESeq 2
dds <- DESeq(dds)

# Tamaños de muestras normalizados
sizeFactors(dds)

# Dispersiones finales estimadas
head(dispersions(dds))
res <- results(dds) 
head(res)

# Ordenar los genes según el p-valor ajustado.
resOrdered <- res[order(res$padj),] 
head(resOrdered)

# Genes se pueden considerar realmente como diferencialmente expresados.
xx <-res[order(res$padj,na.last=NA),] 
resSig2 <- xx[xx$padj < 0.1, ]
dim(resSig2)
plotMA(res, main="MA-plot DESeq2 DC235vsDSS124", ylim=c(-2,2))
rownames(resSig2)



VPSol <- data.frame(resOrdered$log2FoldChange, resOrdered$pvalue, row.names = rownames(resOrdered)) ##Creates a data



##Rename the columns to simplify the dataframe##

VPSol <- VPSol %>% rename(FoldChange = resOrdered.log2FoldChange, p_value = resOrdered.pvalue)

##Create a column with colors depending on the value of Fold Change and p-value##  

VPSol$color <- ifelse((VPSol$FoldChange > 1.5) & (VPSol$p_value < 0.05), "A",
                      ifelse((VPSol$FoldChange < -1.5) & (VPSol$p_value < 0.05), "B",
                             ifelse((VPSol$FoldChange > 1.5) & (VPSol$p_value > 0.05), "C",
                                    ifelse((VPSol$FoldChange < -1.5) & (VPSol$p_value > 0.05), "D",
                                           ifelse((VPSol$FoldChange < 1.5) & (VPSol$p_value > 0.05), "E", "F")))))

##Create plot##

ggplot(VPSol, aes(x=FoldChange, y=p_value)) +
  geom_point(aes(colour = color)) 

palette()

ggplot(VPSol) +
  geom_point(
    data = VPSol,
    aes(x = FoldChange, y = p_value),
    color = "#B25FBC",
    cex = 3
  )
dev.off()
