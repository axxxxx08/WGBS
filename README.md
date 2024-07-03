# A simple workflow for whole-genome bisulfite sequencing (WGBS) data analysis

## Requirements
Before start running the workflow, please ensure that the following software is installed in your environment:

- Snakemake  
- Soapnuke  
- Bismark  

## Usage
### 1. Reference genome preparation
First a reference genome is needed to align your samples with, place it in a genome folder in FastA format (.fa / .fasta). Choose an align tool (bowtie2/hisat2), notice that aligner is important and should be same as the align step
bismark_genome_preparation --bowtie2/--hisat2 <path_to_genome_folder>
