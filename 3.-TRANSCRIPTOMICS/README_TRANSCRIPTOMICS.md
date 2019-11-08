# README TRANSCRIPTOMICS

## Pre-requisitos

Before starting the analysis here are the programs that need to be installed:

## SOFTWARE

* [bwa](https://ipyrad.readthedocs.io/en/latest/)
* [PLINK](https://www.cog-genomics.org/plink2/)
* [vcfTools](https://vcftools.github.io/man_latest.html)
* [R](https://cran.r-project.org)
* [Rstudio (optional)](https://rstudio.com)

## R packages

* **readr**
* **dplyr**
* **tidyr**
* **ggplot2**
* **geosphere**
* **gdsfmt**
* **SNPRelate**
* **MASS**
* **psych**
* **vegan**
* **permute**
* **lattice**
* **magrittr**
* **reshape**

library(limma)
library(edgeR)

## TRASNCRIPTOMICS directory structure:

```
+----- Abies_religiosa_vs_ozone/
|	+--1.-GENOMICS/
|		+--bin/
|	     +--Rstudio/
|	   	    +--3.3_Without_SNPs_in_same_loci.R
|	   	    +--4.2_Relatedness.R
|	   	    +--5.1_Mantel_test.R
|	   	    +--6.1_PCA.R
|	   	    +--7.3_Admixture.R
|	   	    +--8.2_Calculate_He.R
|	     +--Software
|	   	    +--1.1_Run_relaxed_assembly.sh
|	   	    +--2.3_Samples_missdata_maf.sh
|	   	    +--3.1_Calculate_frequences.sh
|	   	    +--3.2_ConvertFiles_vcf_to_plink.sh
|	   	    +--3.4_Extract_positions_HM.sh
|	   	    +--5.1_Calculate_relatedness.sh
|	   	    +--7.1_Calculate_CV_Admixture.sh
|	   	    +--8.1_Calculate_Heterozigozity.sh
|		+--data/
|		+--metadata/
|		+--outputs/
|		+--README_genomics.md
```
## TRANSCRIPTOMICS content

:file_folder: **`/bin`**
Here you will find the scripts that are needed to perform the analyses. The scripts must be used in the order specified.

:file_folder: **`/data`** Aqui se encuentran los archivos producto de la secuenciacion y el analisis de ellos

:file_folder: **`/metadata`** Aqui se encuentran

:file_folder: **`/outputs`**

:page_facing_up: **`/README_genomics`**


# 1.0.- Evaluar secuencias con fastqc


* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)

```
java -jar ../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 4 -phred33 ../../TRANSCRIPTOMICS_RAW/DPVR1_S179_L007_R1_001.fastq.gz ../../TRANSCRIPTOMICS_RAW/DPVR1_S179_L007_R2_001.fastq.gz Trimmer_DPVR1_S179_L007_R1_001_paired.fq.gz Trimmer_DPVR1_S179_L007_R1_001_unpaired.fq.gz Trimmer_DPVR1_S179_L007_R2_001_paired.fq.gz Trimmer_DPVR1_S179_L007_R2_001_unpaired.fq.gz ILLUMINACLIP:../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:28 TRAILING:28 SLIDINGWINDOW:10:28 MINLEN:50 HEADCROP:13

```

   **OUT: barplot_images.png**



## 1.1.-Primero se tiene que obtener la frecuencia que tienen los loci




# 2.0.- Cortar secuencias con Trimmomatic


* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)

## 2.1.-Primero se tiene que obtener la frecuencia que tienen los loci

```
#Do Trimmer  with Trimmomatic-0.36

java -jar ../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 4 -phred33 ../data/RAW/DPVR1_S179_L007_R1_001.fastq.gz ../data/RAW/DPVR1_S179_L007_R2_001.fastq.gz Trimmer_DPVR1_S179_L007_R1_001_paired.fq.gz Trimmer_DPVR1_S179_L007_R1_001_unpaired.fq.gz Trimmer_DPVR1_S179_L007_R2_001_paired.fq.gz Trimmer_DPVR1_S179_L007_R2_001_unpaired.fq.gz ILLUMINACLIP:../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:28 TRAILING:28 SLIDINGWINDOW:10:28 MINLEN:50 HEADCROP:13

# Do fastqc

fastqc *fq.gz

```

**OUT: barplot_images.png**

# 3.0.- Mapeo con BWA


* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)

## 3.1.-Hacer Index


```
bwa index -p ../metadata/INDEX/index_Areligiosa -a is ../metadata/Reference_Transcriptome/GCAT_AB-RNA-1.0.16.fa
```
**OUT: barplot_images.png**

## 3.2.-Mapeo en A. balsamea

```
bwa mem ../metadata/index_GCAT_AB-RNA-1.0.16/index_Areligiosa ../data/TRIMMING/Trimm18s_sw10-28_ml50_28/Trimmer_DPVR1_S179_L007_R1_001_paired.fq.gz ../data/TRIMMING/Trimm18s_sw10-28_ml50_28/Trimmer_DPVR1_S179_L007_R2_001_paired.fq.gz > SC01_15_sw10L50_28.sam
```

# 4.0.- Convertir SAM en BAM


* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)

## 4.1.- Convertir SAM en BAM

```
for i in DC01_15_sw10L50_28 DC04_17_sw10L50_28 DS04_15_sw10L50_28 SC03_15_sw10L50_28 SS02_15_sw10L50_28 DC02_15_sw10L50_28 DC05_15_sw10L50_28 SC01_15_sw10L50_28 SC04_15_sw10L50_28 SS05_15_sw10L50_28 DC03_15_sw10L50_28 DS01_15_sw10L50_28 SC01_17_sw10L50_28 SC05_15_sw10L50_28 DC04_15_sw10L50_28 DS02_15_sw10L50_28 SC02_15_sw10L50_28 SS01_15_sw10L50_28; do samtools view -Sb ../data/SAM/$i.sam > ../data/BAM/$i.bam; done

```

**OUT: barplot_images.png**


# 5.0.- Contar genes en bam file

* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)

## 5.1.-Mapeo con BWA

```
cd ../data/BAM

for i in DC01_15_sw10L50_28 DC04_17_sw10L50_28 DS04_15_sw10L50_28 SC03_15_sw10L50_28 SS02_15_sw10L50_28 DC02_15_sw10L50_28 DC05_15_sw10L50_28 SC01_15_sw10L50_28 SC04_15_sw10L50_28 SS05_15_sw10L50_28 DC03_15_sw10L50_28 DS01_15_sw10L50_28 SC01_17_sw10L50_28 SC05_15_sw10L50_28 DC04_15_sw10L50_28 DS02_15_sw10L50_28 SC02_15_sw10L50_28 SS01_15_sw10L50_28; do samtools view ../data/BAM/$i.bam > $i.seqgenes_28.txt; done

for i in DC01_15_sw10L50_28 DC04_17_sw10L50_28 DS04_15_sw10L50_28 SC03_15_sw10L50_28 SS02_15_sw10L50_28 DC02_15_sw10L50_28 DC05_15_sw10L50_28 SC01_15_sw10L50_28 SC04_15_sw10L50_28 SS05_15_sw10L50_28 DC03_15_sw10L50_28 DS01_15_sw10L50_28 SC01_17_sw10L50_28 SC05_15_sw10L50_28 DC04_15_sw10L50_28 DS02_15_sw10L50_28 SC02_15_sw10L50_28 SS01_15_sw10L50_28; do cut -f 3 $i.seqgenes_28.txt > $i.allgenes_28.txt; done

for i in DC01_15_sw10L50_28 DC04_17_sw10L50_28 DS04_15_sw10L50_28 SC03_15_sw10L50_28 SS02_15_sw10L50_28 DC02_15_sw10L50_28 DC05_15_sw10L50_28 SC01_15_sw10L50_28 SC04_15_sw10L50_28 SS05_15_sw10L50_28 DC03_15_sw10L50_28 DS01_15_sw10L50_28 SC01_17_sw10L50_28 SC05_15_sw10L50_28 DC04_15_sw10L50_28 DS02_15_sw10L50_28 SC02_15_sw10L50_28 SS01_15_sw10L50_28; do sort $i.allgenes_28.txt | uniq -c > $i.countgenes_28.txt; done

for i in DC01_15_sw10L50_28 DC04_17_sw10L50_28 DS04_15_sw10L50_28 SC03_15_sw10L50_28 SS02_15_sw10L50_28 DC02_15_sw10L50_28 DC05_15_sw10L50_28 SC01_15_sw10L50_28 SC04_15_sw10L50_28 SS05_15_sw10L50_28 DC03_15_sw10L50_28 DS01_15_sw10L50_28 SC01_17_sw10L50_28 SC05_15_sw10L50_28 DC04_15_sw10L50_28 DS02_15_sw10L50_28 SC02_15_sw10L50_28 SS01_15_sw10L50_28; do awk '{ sub(/^[ \t]+/, ""); print }' $i.genesorder_28.txt | sed 's/ /\t/' >; done

rm *.bam

```

**OUT: barplot_images.png**

## 5.2.-Statistics con BWA

# 6.0.- Tabla de conteo de transcritos


* **INPUT**:
   * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

* **OUTPUT**:
   * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
   * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)


## 6.1.- Tabla de conteo de transcritos

SCRIPT in 2.-METABOLOMICS/Rstudio/[7.1_Countreads_makematrix.R](bin/Rstudio/7.1_Countreads_makematrix.R)

**OUT: barplot_images.png**


# 7.0.- Tabla de conteo de transcritos


   * **INPUT**:
      * **fitered_file.vcf**(88ind_maxmiss0.9_maf0.05.recode.vcf)

   * **OUTPUT**:
      * **fitered_file.freq**(freq_88ind_maxmiss0.9_maf0.05.frq)
      * **fitered_file.bed**(88ind_maxmiss0.9_maf0.05.bed)


## 7.1.- Tabla de conteo de transcritos

   SCRIPT in 2.-METABOLOMICS/Rstudio/[8.1_5HCvs5DC.R](bin/Rstudio/8.1_5HCvs5DC.R)

   **OUT: barplot_images.png**

      ![](outputs/4.1_barplot_images_SS.png)
      ![](outputs/4.1_barplot_images_conti.png)











:file_folder: **`/bin`**

This is a directory. It contains the scripts and html files results of the scripts.


:file_folder: **`/data`**

This is a directory. It contains a screenshot of my data, because the real data is very heavy.


:file_folder: **`/metadata`**

This is a directory. It contains .csv, .txt and other files to do the analysis.


:file_folder: **`/outputs`**

This is a directory. It contains files product of the scripts.

:page_facing_up: **`/README.md`**

This is a markdown file. It is a description file particular of this directory and analysis.

:page_facing_up: **`/Discussion and conclusion.md`**

This is a markdown file. It is a discussion particular of this section.
