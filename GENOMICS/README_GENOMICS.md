# README

# Pre-requisitos

## Docker
### Descargar imagen en Docker y correr un volumen para utilizar vcfTools
docker pull biocontainers/vcftools
docker run -v /Users/veronicareyesgalindo/Documents/DOCKER/Contenedor_VCFTools:/data -it biocontainers/vcftools /bin/bash

### Corroborar que exista la imagen
docker ps -a

### Si se salío del contenedor encender el contenedor de nuevo
docker restart 5384b5655b7d
docker exec -it 5384b5655b7d bash

## PLINK


## Cluster

I have access a [CONABIO](https://www.gob.mx/conabio) cluster


# Relaxed assembly iPyRAD with *Abies flinckii* and *Abies religiosa*

I used 79 samples of my research group to understand were is the providence of my 10 samples. So, I do my assembly with 89 samples.
This assembly was made relaxed because we want found SNPs with same ID reference in every sequences.

```
------- ipyrad params file (v.0.7.28)-------------------------------------------
TMVB_5SNPradlocus              ## [0] [assembly_name]: Assembly name. Used to name output directories for assembly steps
/LUSTRE/Genetica/gibrahim/ipyrad_Abies ## [1] [project_dir]: Project dir (made in curdir if not present)
                               ## [2] [raw_fastq_path]: Location of raw non-demultiplexed fastq files
Merged: Plate1rawsAbies, Plate2rawsAbies, Plate3rawsAbies, Plate4rawsAbies, Plate5rawAbies ## [3] [barcodes_path]: Location of barcodes file
                               ## [4] [sorted_fastq_path]: Location of demultiplexed/sorted fastq files
denovo                         ## [5] [assembly_method]: Assembly method (denovo, reference, denovo+reference, denovo-reference)
                               ## [6] [reference_sequence]: Location of reference sequence file
gbs                            ## [7] [datatype]: Datatype (see docs): rad, gbs, ddrad, etc.
TGCAG, CGG                     ## [8] [restriction_overhang]: Restriction overhang (cut1,) or (cut1, cut2)
0                              ## [9] [max_low_qual_bases]: Max low quality base calls (Q<20) in a read
43                             ## [10] [phred_Qscore_offset]: phred Q score offset (33 is default and very standard)
8                              ## [11] [mindepth_statistical]: Min depth for statistical base calling
8                              ## [12] [mindepth_majrule]: Min depth for majority-rule base calling
10000                          ## [13] [maxdepth]: Max cluster depth within samples
0.9                            ## [14] [clust_threshold]: Clustering threshold for de novo assembly
0                              ## [15] [max_barcode_mismatch]: Max number of allowable mismatches in barcodes
2                              ## [16] [filter_adapters]: Filter for adapters/primers (1 or 2=stricter)
80                             ## [17] [filter_min_trim_len]: Min length of reads after adapter trim
2                              ## [18] [max_alleles_consens]: Max alleles per site in consensus sequences
0                              ## [19] [max_Ns_consens]: Max N's (uncalled bases) in consensus (R1, R2)
4, 4                         ## [20] [max_Hs_consens]: Max Hs (heterozygotes) in consensus (R1, R2)
1                              ## [21] [min_samples_locus]: Min # samples per locus for output
5, 5                         ## [22] [max_SNPs_locus]: Max # SNPs per locus (R1, R2)
4, 4                           ## [23] [max_Indels_locus]: Max # of indels per locus (R1, R2)
0.5                            ## [24] [max_shared_Hs_locus]: Max # heterozygous sites per locus (R1, R2)
0, 0, 0, 0                     ## [25] [trim_reads]: Trim raw read edges (R1>, <R1, R2>, <R2) (see docs)
0, 0, 0, 0                     ## [26] [trim_loci]: Trim locus edges (see docs) (R1>, <R1, R2>, <R2)
p, s, v, k, n, g               ## [27] [output_formats]: Output formats (see docs)
                               ## [28] [pop_assign_file]: Path to population assignment file

```
# Strict assembly vcfTools

## Selected only *Abies religiosa* samples
vcftools --vcf TMVB_5SNPradlocus.vcf --keep 89_ind.txt --max-missing 0.9 --maf 0.05 --recode --out 89ind_maxmiss0.9_maf0.05

## Evalue diferentes valores de missing data y MAF en los datos

vcftools --vcf without_duplicates.recode.vcf --max-missing 0.9 --maf 0.05 --recode --out without_duplicates_maxmiss0.9_maf0.05
vcftools --vcf without_duplicates.recode.vcf --max-missing 0.95 --maf 0.05 --recode --out without_duplicates_maxmiss0.95_maf0.05
vcftools --vcf without_duplicates.recode.vcf --max-missing 0.85 --maf 0.05 --recode --out without_duplicates_maxmiss0.85_maf0.05


## Determinar missing data en las muestras

vcftools --vcf file.vcf --missing-indv --out name_file
vcftools --vcf without_duplicates_maxmiss0.95_maf0.05.recode.vcf --missing-indv --out missing-indv_without_duplicates_maxmiss0.95_maf0.05
vcftools --vcf without_duplicates_maxmiss0.9_maf0.05.recode.vcf --missing-indv --out missing-indv_without_duplicates_maxmiss0.9_maf0.05
vcftools --vcf without_duplicates_maxmiss0.85_maf0.05.recode.vcf --missing-indv --out missing-indv_without_duplicates_maxmiss0.85_maf0.05


# Covert files

## Convertir los archivos vcf a archivos ped map
vcftools --vcf 63ind_maxmiss0.9_maf0.05.recode.vcf --plink --out 63ind_maxmiss0.9_maf0.05

## Convertir archivos plink a archivos bed bim am
./plink --file 63ind_maxmiss0.9_maf0.05 --out 63ind_maxmiss0.9_maf0.05 --make-bed


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
