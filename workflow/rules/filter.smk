rule soapnuke:
    input:
        fastq_1 = lambda wildcards: get_path(samples_df, wildcards, 'fq1'),
        fastq_2 = lambda wildcards: get_path(samples_df, wildcards, 'fq2')
    output:
        trimmed_finish = os.path.join(config["outdir"], "1.trimmed/{sample}/{sample}_trimmed.finish")
    params:
        out_dir = os.path.join(config["outdir"], "1.trimmed/{sample}"),
        clean1 = "{sample}_1_trimmed.fq.gz",
        clean2 = "{sample}_2_trimmed.fq.gz"
    benchmark:
        "1.benchmarks/1.trimmed/{sample}.benchmark.txt"
    log:
        "1.logs/1.trimmed/{sample}.log"
    threads: config["threads"]["soapnuke"]
    priority: 0
    shell:
        '''
        SOAPnuke filter -l 30 -q 0.5 -1 {input.fastq_1} -2 {input.fastq_2} -C {params.clean1} -D {params.clean2} -o {params.out_dir} -T {threads} 2>{log}
        touch {output.trimmed_finish}
        '''
