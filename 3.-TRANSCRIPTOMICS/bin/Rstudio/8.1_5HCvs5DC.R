
# Convert dataframe to data matrix
alldata<-read.delim("../Counts/bwa/allreadsgenes.txt")
alldata <- as.data.frame(alldata)
  
x<-alldata
rownames(x)<-alldata[,1]
x<-x[ ,2:ncol(x)]

alldata<-as.matrix(x)

##################################################################################################################
##################################################################################################################
# Select data to compare 
DCvsHC<- subset(alldata, select = -c(DS_1, DS_2, DS_4,
                                     HS_1, HS_2, HS_5,
                                     HC17, DC47))
alldata<- DCvsHC

############################################
# Add characteristics 
############################################
tratamiento <- c("DC","DC","DC","DC","DC",
                 "HC","HC","HC","HC","HC")
label<- c("DC_1", "DC_2","DC_3","DC_4","DC_5",
          "HC_1","HC_2","HC_3","HC_4","HC_5")
samples<-c("DC1", "DC2","DC3","DC4","DC5",
           "HC1","HC2","HC3","HC4","HC5")
targets<- data.frame(tratamiento,label,samples)
rownames(targets)<- label
targets

### Filtering genes 
table(rowSums(alldata)==0)
suma <- rowSums(alldata)
filtconteos <- alldata[suma != 0,] 
dim(filtconteos)

##################################################################################################################
##################################################################################################################
# EdgeR
library(limma)
library(edgeR)

## Clase DGEList
d <- DGEList(counts = filtconteos[,1:10], group = targets$tratamiento) ## Normalización
colnames(d) <- targets$label

## Normalizacion
d <- calcNormFactors(d)
plotMDS(d, main="plotMDS DCvsHC")

## Estimación de las dispersiones
d <- estimateCommonDisp(d,verbose=TRUE)
d <- estimateTagwiseDisp(d)
plotBCV(d, main="plotBCV DCvsHC")

## Pruebas
et <- exactTest(d,pair=c("HC","DC"))
top<- topTags(et, n= Inf)
hist(top$table$FDR, breaks = 100, main = "Hist FDR DCvsHC")
abline(v=0.05, col="red",lwd=3)

##################################################################################################################
##################################################################################################################
# DESeq2
library(DESeq2)

### Clase DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData=filtconteos, colData= targets, design=~tratamiento)

### Pruebas
dds <- DESeq(dds)
res <- results(dds)

### Normalizacion de ambos datos

#edgeR
d$samples$norm.factors #edgeR

#DESeq2
sizeFactors(dds) #DESeq2

### Comparar valores de dispersion
# edgeR
# Primero calcula una dispersión común 
d$common.dispersion

# Luego una dispersión gen a gen a partir de la común
head(d$tagwise.dispersion)
# Se queda con la que mejor se ajuste de las dos estimaciones

# DESeq2
# Primero calcula una estimación gen a gen 
head(mcols(dds)$dispGeneEs)
# Luego através de un ajuste con la media de los conteos
# estima la dispersión
head(mcols(dds)$dispersion)

### Comparar las pruebas, es decir, los p-valores y demás resultados que cada paquete ha calculado para cada gen
# edgeR

topTags(et, n= Inf)

# DESeq2
res[rownames(topTags(et, n= Inf)),]


# edgeR
de <- decideTestsDGE(et, p.value=0.1)
detags <- rownames(d)[as.logical(de)]
plotSmear(et, de.tags=detags, main="plotSmear de edgeR") > abline(h=0, col="red", lwd=3)

# DESeq2
plotMA(res, main="MA-plot DESeq2", ylim=c(-5,5))


### Ordenar los genes según el p-valor adjustado que han obtenido
# edgeR
topSig <- top[top$table$FDR < 0.1, ]
dim(topSig)
genesDEedgeR <- rownames(topSig)
genesDEedgeR
# DESeq2
# Ordenar por p-valores
resOrdered <- res[order(res$padj),]
# Solo genes DE
xx <-res[order(res$padj,na.last=NA),] 
resSig2 <- xx[xx$padj < 0.1, ]
dim(resSig2)
genesDEDESeq2 <- rownames(resSig2)
genesDEDESeq2 
### Cuantos genes DE en común existen
genesDEcomunes <- intersect(genesDEedgeR,genesDEDESeq2) 
head(genesDEcomunes)
str(genesDEcomunes)

### Plotear diagrama de Venn
library(VennDiagram)
grid.newpage() #Para limpiar la ventana gráfica
dim(resSig2)
dim(topSig)
str(genesDEcomunes)
plot2 <- draw.pairwise.venn(22,20,7,category = c("DESeq2","edgeR"),
                            lty = "blank", 
                            fill = c("cyan3", "hotpink2"))
genesDEcomunes

#AB_045531_T.1= 
#AB_036475_T.1= ATEP3,ATCHITIV,CHIV,EP3	homolog of carrot EP3-3 chitinase
#Glyco_hydro_19	Chitinase class I
#AB_035458_T.1= Leucine-rich repeat transmembrane protein kinase
#Pkinase_Tyr	Protein tyrosine kinase
#Pkinase	Protein kinase domain
#AB_029013_T.1=
#AB_015092_T.1=-Major facilitator superfamily protein
#Nodulin-like	Nodulin-like
#AB_029334_T.1=-Concanavalin A-like lectin protein kinase family protein
#Lectin_legB	Legume lectin domain
#Pkinase	Protein kinase domain
#Pkinase_Tyr	Protein tyrosine kinase
#AB_018867_T.1=
