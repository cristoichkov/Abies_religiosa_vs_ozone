# README

# Pre-requisitos

### ipyrad
[ipyrad](https://ipyrad.readthedocs.io/en/latest/), interactive assembly and analysis toolkit for restriction-site associated DNA (RAD-seq) and related data types.

### plink
[PLINK](A set of tools written in Perl and C++ for working with VCF files.), command-line program, to do several of the most demanding jobs, including identity-by-state matrix computation, distance-based clustering, LD-based pruning, haplotype block identification, and association analysis max(T) permutation tests.

### vcfTools
[vcfTools](https://vcftools.github.io/man_latest.html), set of tools written in Perl and C++ for working with VCF files.


# You can install the programs with docker o check if you have access in a cluster

## Docker
### Descargar imagen en Docker y correr un volumen para utilizar vcfTools
docker pull biocontainers/vcftools
docker run -v /Users/veronicareyesgalindo/Documents/DOCKER/Contenedor_VCFTools:/data -it biocontainers/vcftools /bin/bash

### Corroborar que exista la imagen
docker ps -a

### Si se salío del contenedor encender el contenedor de nuevo
docker restart 5384b5655b7d
docker exec -it 5384b5655b7d bash


## Cluster

I have access a [CONABIO](https://www.gob.mx/conabio) cluster




# 1. RUN ASSEMBLY: Relaxed assembly iPyRAD with *Abies flinckii* and *Abies religiosa*



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
# 2 Strict assembly vcfTools and PLINK
I used 79 samples of my research group to understand were is the providence of my 10 samples. So, I do my assembly with 89 samples.
This assembly was made relaxed because we want found SNPs with same ID reference in every sequences.
Se requiere sacar del ensamble general solamente a las muestras de Abies religiosa (89 individuals)


## 2.1 Check perfect missing data max for your samples


## 2.2 Check perfect maf for your samples

## 2.3 Selected only 89 *Abies religiosa* samples, with missing data max 10% and maf 0.05

```
vcftools --vcf TMVB_5SNPradlocus.vcf --keep 89_ind.txt --max-missing 0.9 --maf 0.05 --recode --out 89ind_maxmiss0.9_maf0.05
```

# 3 Make LD linkage desequilibrium (delete a SNPs in the same loci)

## 3.1 Primero se tiene que obtener la frecuencia que tienen los loci

```
vcftools --vcf 88ind_maxmiss0.9_maf0.05.recode.vcf --freq --out freq_88ind_maxmiss0.9_maf0.05
vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --freq --out freq_89ind_maxmiss0.9_maf0.05

```
## Para realizar esto se utilizará el script:

**/Users/geyev15/Dropbox/TESIS_OZONO_ORGANIZADO/GENOMICS/bin/SNPS_s88_same_loci_0.9.R**
Del script obtuve un archivo .txt con los locus que conservaré en los analisis. Edite los archivos con TextWrangler. Trate en la terminal pero no lo logré

locus_13 8
locus_13:8

## 3.2 Convertir archivos vcf en plink

El comando debe ser en archivos plink
```
vcftools --vcf 88ind_maxmiss0.9_maf0.05.recode.vcf --plink --out 88ind_maxmiss0.9_maf0.05
```
El archivo anterior se utilizó para descartar esos locus con el comando en **VCFTools**:
Mantener las variantes del txt. Este .txt se uso para descartar a estos SNPs utilizando comandos plink con los archivos map, ped y txt

## 3.3 Extraer posisiones en archivos plink  

```
./plink --file 88ind_maxmiss0.9_maf0.05 --extract positions_s88_Ar0.9.txt  --make-bed --out snp_withoutDupLoci_88s_maxmiss0.9_maf0.05
```

# 4 Calcular coeficiente de relación (relatedness)



# 4.1 Se calcula con PLINK1.9, los archivos se convierten a plink y a vcf, utilizando los siguientes comandos:
```
./plink --bfile snp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --make-rel square --make-bed --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --bfile relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
./plink --file relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05 --recode vcf --out relsnp_withoutDupLoci_without_duplicates88s_maxmiss0.9_maf0.05
```


# 5 Estructura genética de las poblaciones con admixture

# 5.1 Plotear errores cross-validation
Cada vez que corro un admixture debo cambiar de lugar los archivos, de lo contrario se sobreescriben

for K in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20;
do ./admixture --cv=20 snp_withoutDupLoci_88s_maxmiss0.9_maf0.05.bed $K | tee log${K}.out; done
grep -h CV log*.out > logall_snp_withoutDupLoci_88s_maxmiss0.9_maf0.05

# 5.2 Primero debo modificar el logall.txt y el archivo .fam

CV error (K=1): 0.44124
01	0.86369

###fam file

ArDlD5	ArDlD5	0	0	0	-9
SantaRosaXochiac	ArDlD5	0	0	0	-9


# 6 Calculate Heterocigozity

# 6.1
vcftools --vcf 89ind_maxmiss0.9_maf0.05.recode.vcf --hardy --out samples_hardy_snp_withoutDupLoci_89ind_maxmiss0.9_maf0.05
