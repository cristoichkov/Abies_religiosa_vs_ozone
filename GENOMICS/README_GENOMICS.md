# README


# Descargue la imagen y corrí un volumen para utilizar vcfTools
docker pull biocontainers/vcftools
docker run -v /Users/veronicareyesgalindo/Documents/DOCKER/Contenedor_VCFTools:/data -it biocontainers/vcftools /bin/bash
docker ps -a
docker restart 5384b5655b7d 
docker exec -it 5384b5655b7d bash


# Convertir los archivos vcf a archivos ped map
vcftools --vcf 63ind_maxmiss0.9_maf0.05.recode.vcf --plink --out 63ind_maxmiss0.9_maf0.05

# Convertir archivos plink a archivos bed bim am
./plink --file 63ind_maxmiss0.9_maf0.05 --out 63ind_maxmiss0.9_maf0.05 --make-bed


docker pull ncbi/blast
docker run -v /Users/genyev15/Documents/Contenedor_blast:/data -it ncbi/blast /bin/bash
docker ps -a
docker restart f1691f018b3a 
docker exec -it f1691f018b3a bash



# 1. Seleccional muestras de la distribución de Abies religiosa en la FVTM (88 individuos)

```
vcftools --vcf TMVB_5SNPradlocus.vcf --keep 88_ind.txt --max-missing 0.9 --maf 0.05 --recode --out 88ind_maxmiss0.9_maf0.05

vcftools --vcf TMVB_5SNPradlocus.vcf --keep 89_ind.txt --max-missing 0.9 --maf 0.05 --recode --out 89ind_maxmiss0.9_maf0.05
```

# Descartar SNPs en el mismo locus(manteniendo a los SNPs con mayor MAF)
Para realizar esto se utilizará el script:

**/Users/geyev15/Dropbox/TESIS_OZONO_ORGANIZADO/GENOMICS/bin/SNPS_s88_same_loci_0.9.R**

Primero se tiene que obtener la frecuencia que tienen los loci

```
vcftools --vcf 88ind_maxmiss0.9_maf0.05.recode.vcf --freq --out freq_88ind_maxmiss0.9_maf0.05
vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --freq --out freq_89ind_maxmiss0.9_maf0.05

```
Del script obtuve un archivo .txt con los locus que conservaré en los analisis. Edite los archivos con TextWrangler. Trate en la terminal pero no lo logré

locus_13 8
locus_13:8


El comando debe ser en archivos plink
```
vcftools --vcf 88ind_maxmiss0.9_maf0.05.recode.vcf --plink --out 88ind_maxmiss0.9_maf0.05
```
El archivo anterior se utilizó para descartar esos locus con el comando en **VCFTools**:
Mantener las variantes del txt. Este .txt se uso para descartar a estos SNPs utilizando comandos plink con los archivos map, ped y txt

```
./plink --file 88ind_maxmiss0.9_maf0.05 --extract positions_s88_Ar0.9.txt  --make-bed --out snp_withoutDupLoci_88s_maxmiss0.9_maf0.05
```

Convertir a archivos plink para futuros analisis

```
./plink --bfile snp_withoutDupLoci_88s_maxmiss0.9_maf0.05 --recode --out snp_withoutDupLoci_88s_maxmiss0.9_maf0.05
```

Convertir plink en vcf para futuros análisis
```
./plink --file snp_withoutDupLoci_88s_maxmiss0.9_maf0.05 --recode vcf --out snp_withoutDupLoci_88s_maxmiss0.9_maf0.05
```


# Calcular coeficiente de relación (relatedness)

Se calcula con PLINK1.9, utilizando los siguientes comandos:

```
./plink --bfile snp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --make-rel square --make-bed --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --bfile relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --file relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode vcf --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05


./plink --bfile snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05 --make-rel square --make-bed --out relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05
./plink --bfile relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05 --recode --out relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05
./plink --file relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05 --recode vcf --out relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05
```
Se utiliza el script :

```
/Users/geyev15/Dropbox/TESIS_OZONO_ORGANIZADO/GENOMICS/bin/relsnp_snp_withoutDupLoci_88ind_maxmiss0.9_maf0.05.R
/Users/geyev15/Dropbox/TESIS_OZONO_ORGANIZADO/GENOMICS/bin/relsnp_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05.R

``
 
#Estructura genética de las poblaciones con admixture

Plotear errores cross-validation
Cada vez que corro un admixture debo cambiar de lugar los archivos, de lo contrario se sobreescriben

for K in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
do ./admixture --cv=20 snp_withoutDupLoci_88s_maxmiss0.9_maf0.05.bed $K | tee log${K}.out; done
grep -h CV log*.out > logall_snp_withoutDupLoci_88s_maxmiss0.9_maf0.05


Utilice el script para el admixture
Primero debo modificar el logall.txt

CV error (K=1): 0.44124
01	0.86369

# Para correr un mejor plot utilice el script de Lewis y modifique el archivo .fam añadiendo mis poblaciones
ArDlD5	ArDlD5	0	0	0	-9
SantaRosaXochiac	ArDlD5	0	0	0	-9


# Heterocigosis


vcftools --vcf snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05.vcf --keep samples_het.txt --het --recode --out samples_het_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05

vcftools --vcf samples_het_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05.recode.vcf --het --out samples_het_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05


vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --het --out samples_het_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05

vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --hardy --out samples_hardy_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05



vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --keep samples_het.txt  --het --out samples_het_snp_withoutDupLoci_10ind_maxmiss0.9_maf0.05

vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --keep samples_het.txt  --hardy --out samples_hardy_snp_withoutDupLoci_10ind_maxmiss0.9_maf0.05



vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --keep samples_het_sana.txt  --het --out samples_het_snp_withoutDupLoci_5Sind_maxmiss0.9_maf0.05

vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --keep samples_het_da.txt  --het --out samples_het_snp_withoutDupLoci_5Dind_maxmiss0.9_maf0.05

vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --keep samples_het_relat.txt  --het --out samples_het_snp_withoutDupLoci_9ind_related_maxmiss0.9_maf0.05




