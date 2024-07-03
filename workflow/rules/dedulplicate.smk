rule bismark_duplicate:
    input:
        align_finish = os.path.join(config["outdir"], "2.bismark_align/{sample}/{sample}_align.finish")
    output:
        dedulplicate_finish = os.path.join(config["outdir"], "3.bismark_deduplicate/{sample}/{sample}_dedulplicate.finish"),
        duplicate = os.path.join(config["outdir"], "3.bismark_deduplicate/{sample}/{sample}_1_trimmed_bismark_bt2_pe.deduplicated.bam")
    params:
        bam_file = os.path.join(config["outdir"], "2.bismark_align/{sample}/{sample}_1_trimmed_bismark_bt2_pe.bam"),
        dup_dr = os.path.join(config["outdir"], "3.bismark_deduplicate/{sample}")
    benchmark:
        "1.benchmarks/3.bismark_deduplicate/{sample}.benchmark.txt"
    log:
        "1.logs/3.bismark_deduplicate/{sample}.log"
    threads: config["threads"]["bis_dedul"]
    priority: 0
    shell:
        '''
        deduplicate_bismark -p --parallel {threads} --bam {params.bam_file} --output_dir {params.dup_dr} 2> {log}
        cat {input.align_finish} > {output.dedulplicate_finish}
        '''

