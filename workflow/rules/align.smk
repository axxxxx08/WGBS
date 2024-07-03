rule bismark_alignment:
    input:
        trimmed_finish = os.path.join(config["outdir"], "1.trimmed/{sample}/{sample}_trimmed.finish")
    output:
        align_finish = os.path.join(config["outdir"], "2.bismark_align/{sample}/{sample}_align.finish")
    params:
        alin_dir = os.path.join(config["outdir"], "2.bismark_align/{sample}"),
        bam_file = os.path.join(config["outdir"], "2.bismark_align/{sample}/{sample}_1_trimmed_bismark_bt2_pe.bam"),
        trimmed_fastq_1 = os.path.join(config["outdir"], "1.trimmed/{sample}/{sample}_1_trimmed.fq.gz"),
        trimmed_fastq_2 = os.path.join(config["outdir"], "1.trimmed/{sample}/{sample}_2_trimmed.fq.gz")
    benchmark:
        "1.benchmarks/2.bismark_align/{sample}.benchmark.txt"
    log:
        "1.logs/2.bismark_align/{sample}.log"
    threads: config["threads"]["bis_align"]
    priority: 0
    shell:
        '''
        bismark --bowtie2 --multicore {threads} --genome {REFERENCE_DIR} -o {params.alin_dir} -1 {params.trimmed_fastq_1} -2 {params.trimmed_fastq_2} 2> {log}
        cat {input.trimmed_finish} > {output.align_finish}
        '''
