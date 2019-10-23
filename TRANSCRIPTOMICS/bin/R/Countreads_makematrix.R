## Datos para expresion diferencial (mapeo BWA)
## 15 Oct 2018
## Veronica Reyes
x
x<- c("DC01_15","DC02_15","DC03_15","DC04_15","DC05_15",
      "DS01_15","DS02_15","DS04_15",
      "HC01_15","HC02_15","HC03_15","HC04_15","HC05_15",
      "HS01_15", "HS02_15", "HS05_15",
      "HC01_17", "DC04_17"
      )
for(i in x){ ; do
${i}<-read.delim("../../Counts/Genes_sw10/${i}_sw10L50.genesorder.txt", header= FALSE)
}



# Cargar archivos con numero de reads
DC01_15<-read.delim("../../Counts/Genes_sw10/DC01_15_sw10L50.genesorder.txt", header= FALSE)
DC02_15<-read.delim("../../Counts/Genes_sw10/DC02_15_sw10L50.genesorder.txt", header= FALSE)
DC03_15<-read.delim("../../Counts/Genes_sw10/DC03_15_sw10L50.genesorder.txt", header= FALSE)
DC04_15<-read.delim("../../Counts/Genes_sw10/DC04_15_sw10L50.genesorder.txt", header= FALSE)
DC05_15<-read.delim("../../Counts/Genes_sw10/DC05_15_sw10L50.genesorder.txt", header= FALSE)

DS01_15<-read.delim("../../Counts/Genes_sw10/DS01_15_sw10L50.genesorder.txt", header= FALSE)
DS02_15<-read.delim("../../Counts/Genes_sw10/DS02_15_sw10L50.genesorder.txt", header= FALSE)
DS04_15<-read.delim("../../Counts/Genes_sw10/DS04_15_sw10L50.genesorder.txt", header= FALSE)

HC01_15<-read.delim("../../Counts/Genes_sw10/SC01_15_sw10L50.genesorder.txt", header= FALSE)
HC02_15<-read.delim("../../Counts/Genes_sw10/SC02_15_sw10L50.genesorder.txt", header= FALSE)
HC03_15<-read.delim("../../Counts/Genes_sw10/SC03_15_sw10L50.genesorder.txt", header= FALSE)
HC04_15<-read.delim("../../Counts/Genes_sw10/SC04_15_sw10L50.genesorder.txt", header= FALSE)
HC05_15<-read.delim("../../Counts/Genes_sw10/SC05_15_sw10L50.genesorder.txt", header= FALSE)

HS01_15<-read.delim("../../Counts/Genes_sw10/SS01_15_sw10L50.genesorder.txt", header= FALSE)
HS02_15<-read.delim("../../Counts/Genes_sw10/SS02_15_sw10L50.genesorder.txt", header= FALSE)
HS05_15<-read.delim("../../Counts/Genes_sw10/SS05_15_sw10L50.genesorder.txt", header= FALSE)

HC01_17<-read.delim("../../Counts/Genes_sw10/SC01_17_sw10L50.genesorder.txt", header= FALSE)
DC04_17<-read.delim("../../Counts/Genes_sw10/DC04_17_sw10L50.genesorder.txt", header= FALSE)

head(DC04_17)
# Cambiar nombre de columnas
colnames(DC01_15)<- c("number_reads", "name_gen")
colnames(DC02_15)<- c("number_reads", "name_gen")
colnames(DC03_15)<- c("number_reads", "name_gen")
colnames(DC04_15)<- c("number_reads", "name_gen")
colnames(DC05_15)<- c("number_reads", "name_gen")

colnames(DS01_15)<- c("number_reads", "name_gen")
colnames(DS02_15)<- c("number_reads", "name_gen")
colnames(DS04_15)<- c("number_reads", "name_gen")

colnames(HC01_15)<- c("number_reads", "name_gen")
colnames(HC02_15)<- c("number_reads", "name_gen")
colnames(HC03_15)<- c("number_reads", "name_gen")
colnames(HC04_15)<- c("number_reads", "name_gen")
colnames(HC05_15)<- c("number_reads", "name_gen")

colnames(HS01_15)<- c("number_reads", "name_gen")
colnames(HS02_15)<- c("number_reads", "name_gen")
colnames(HS05_15)<- c("number_reads", "name_gen")

colnames(HC01_17)<- c("number_reads", "name_gen")
colnames(DC04_17)<- c("number_reads", "name_gen")
head(DC04_17)

# Cambiar orden de columnas

all<- data.frame(DC01_15$name_gen, DC01_15$number_reads)
head(all)
all$DC_2 <- DC02_15$number_reads[match(all$DC01_15.name_gen, DC02_15$name_gen)]
all$DC_3 <- DC03_15$number_reads[match(all$DC01_15.name_gen, DC03_15$name_gen)]
all$DC_4 <- DC04_15$number_reads[match(all$DC01_15.name_gen, DC04_15$name_gen)]
all$DC_5 <- DC05_15$number_reads[match(all$DC01_15.name_gen, DC05_15$name_gen)]

all$DS_1 <- DS01_15$number_reads[match(all$DC01_15.name_gen, DS01_15$name_gen)]
all$DS_2 <- DS02_15$number_reads[match(all$DC01_15.name_gen, DS02_15$name_gen)]
all$DS_4 <- DS04_15$number_reads[match(all$DC01_15.name_gen, DS04_15$name_gen)]

all$HC_1 <- HC01_15$number_reads[match(all$DC01_15.name_gen, HC01_15$name_gen)]
all$HC_2 <- HC02_15$number_reads[match(all$DC01_15.name_gen, HC02_15$name_gen)]
all$HC_3 <- HC03_15$number_reads[match(all$DC01_15.name_gen, HC03_15$name_gen)]
all$HC_4 <- HC04_15$number_reads[match(all$DC01_15.name_gen, HC04_15$name_gen)]
all$HC_5 <- HC05_15$number_reads[match(all$DC01_15.name_gen, HC05_15$name_gen)]

all$HS_1 <- HS01_15$number_reads[match(all$DC01_15.name_gen, HS01_15$name_gen)]
all$HS_2 <- HS02_15$number_reads[match(all$DC01_15.name_gen, HS02_15$name_gen)]
all$HS_5 <- HS05_15$number_reads[match(all$DC01_15.name_gen, HS05_15$name_gen)]

all$HC17 <- HC01_17$number_reads[match(all$DC01_15.name_gen, HC01_17$name_gen)]
all$DC47 <- DC04_17$number_reads[match(all$DC01_15.name_gen, DC04_17$name_gen)]

head(all)


#Cambiar nombres a columnas

colnames(all)[1]<- ""
colnames(all)[2]<- "DC_1"
head(all)

# Cambiar NA por 0´s

all<- as.data.frame(all, na.rm=TRUE)
all[is.na(all)]<- 0


# Exportar tabla a formato txt
write.table(all, file="OUTS/allreadsgenes.txt", sep = "\t", eol = "\n", dec = ".", 
            row.names = TRUE, col.names = TRUE)
