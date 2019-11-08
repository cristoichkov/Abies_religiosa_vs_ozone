#! /bin/bash
#SBATCH -p keri 
#SBATCH -n 2
#SBATCH --mem=50000

#Do Trimmer  with Trimmomatic-0.36

java -jar ../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 4 -phred33 ../../TRANSCRIPTOMICS_RAW/DPVR9_S187_L007_R1_001.fastq.gz ../../TRANSCRIPTOMICS_RAW/DPVR9_S187_L007_R2_001.fastq.gz Trimmer_DPVR9_S187_L007_R1_001_paired.fq.gz Trimmer_DPVR9_S187_L007_R1_001_unpaired.fq.gz Trimmer_DPVR9_S187_L007_R2_001_paired.fq.gz Trimmer_DPVR9_S187_L007_R2_001_unpaired.fq.gz ILLUMINACLIP:../../Programas/Trimmomatic/Trimmomatic_bin/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:10:28 MINLEN:50

# Do fastqc

fastqc *fq.gz
