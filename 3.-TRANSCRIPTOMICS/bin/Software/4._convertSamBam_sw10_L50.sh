#!/bin/bash
 
#SBATCH -p keri 
#SBATCH -n 5
#SBATCH --mem=10000

# Usar contenedor samtools

for i in DC01_15_sw10L50 DC04_17_sw10L50 DS04_15_sw10L50 SC03_15_sw10L50 SS02_15_sw10L50 DC02_15_sw10L50 DC05_15_sw10L50 SC01_15_sw10L50 SC04_15_sw10L50 SS05_15_sw10L50 DC03_15_sw10L50 DS01_15_sw10L50 SC01_17_sw10L50 SC05_15_sw10L50 DC04_15_sw10L50 DS02_15_sw10L50 SC02_15_sw10L50 SS01_15_sw10L50; do docker run -v /LUSTRE/Genetica/vreyes/TRANSCRIPTOMICS_MAP/Alignment/alignment_AbP_paired_sw10_L50:/data biocontainers/samtools samtools view -Sb $i.sam > $i.bam; done

