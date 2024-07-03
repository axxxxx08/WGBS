# A simple workflow for whole-genome bisulfite sequencing (WGBS) data analysis

## Requirements
Before start running the workflow, please ensure that the following software is installed in your environment:

- Snakemake (>=8.14.0)  
- SOAPnuke (>=2.0)  
- Bismark (>=0.24.2)  
## Installation
```
git clone https://github.com/axxxxx08/WGBS.git
```

## Usages
### 1. Reference genome preparation
A reference genome is required for the Bismark alignment step. The reference genome file should be placed in a directory and must be in `FastA` format (.fa or .fasta). 
```
bismark_genome_preparation --bowtie2/--hisat2 <path_to_genome_folder>
```
**Tips:** You can choose either bowtie2 or hisat2 as your aligner, but it must be consistent with the alignment step (default: bowtie2).

### 2. Generate your own config file
To generate a config file for running Snakemake, you can run the script generate_config.py in the `workflow/scripts` directory. Or, write your own config file and place it in the `workflow/config` directory.
```
generate_config.py --samplefile sample.txt --outdir your_output_dir --config_output workflow/config --ref_dir your_reference_genome_dir
```
**Tips:** The sample file should be formatted like below:  

| id  | fq1  | fq2  |
| ------------- | ------------- | ------------- |
| Sample1  | /dir/sample1_1.fq.gz  | /dir/sample1_2.fq.gz  |
| Sample2  | /dir/sample2_1.fq.gz  | /dir/sample2_2.fq.gz  |

### 3. Running snakemake
Now you can use Snakemake to run your samples. Before running, you can add --dryrun to Snakemake to check for any potential problems.
```
snakemake -s workflow/Snakefile -c cores --dryrun
```
If there are no problems:
```
snakemake -s workflow/Snakefile -c cores
```
**Notes:**
- Check the number of CPUs on your server, and choose appropriate cores and threads when running Snakemake. The threads can be manually adjusted in the config file.
- Choose proper parameters for each step; these can be manually changed in the `.smk` files within the `workflow/rules` directory.
- Verify the config file to ensure the correct paths of output directory, sample file, and reference genome are specified.
