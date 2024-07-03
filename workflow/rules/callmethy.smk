rule bismark_extract:
    input:
        dedulplicate_finish = os.path.join(config["outdir"],"3.bismark_deduplicate/{sample}/{sample}_dedulplicate.finish"),
        bam_dedup_file = os.path.join(config["outdir"],"3.bismark_deduplicate/{sample}/{sample}_1_trimmed_bismark_bt2_pe.deduplicated.bam")
    output:
        extr_dr = directory(os.path.join(config["outdir"],"4.bismark_methylation/{sample}")),
        call_finish = os.path.join(config["outdir"],"4.bismark_methylation/{sample}/{sample}_align.finish")
    benchmark:
        "1.benchmarks/4.bismark_methylation/{sample}.benchmark.txt"
    log:
        "1.logs/4.bismark_methylation/{sample}.log"
    threads: config["threads"]["bis_call"]
    priority: 100
    shell:
        '''
        bismark_methylation_extractor --cytosine_report -p --no_overlap --gzip --multicore {threads} --output {output.extr_dr} --genome_folder {REFERENCE_DIR} {input.bam_dedup_file} 2> {log}
        cat {input.dedulplicate_finish} > {output.call_finish}
        '''

