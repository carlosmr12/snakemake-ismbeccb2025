from snakemake.io import glob_wildcards

# Dynamically determine the list of samples from the reads files
SAMPLES, = glob_wildcards("../reads/{sample}.fasta")

rule all:
    input:
        expand("mapped_reads_{sample}.txt", sample=SAMPLES)

rule index_reference:
    input:
        "reference.fasta"
    output:
        "reference.index.done"
    shell:
        "bwa index {input} && touch {output}"

rule align_reads:
    input:
        index_done="reference.index.done",
        reads="../reads/{sample}.fasta"
    output:
        "alignment_{sample}.sam"
    threads: 4
    shell:
        "bwa mem reference.fasta {input.reads} > {output}"

rule sort_alignment:
    input:
        "alignment_{sample}.sam"
    output:
        "alignment_{sample}.sorted.bam"
    shell:
        "samtools sort {input} -o {output}"

rule index_alignment:
    input:
        "alignment_{sample}.sorted.bam"
    output:
        "alignment_{sample}.sorted.bam.bai"
    shell:
        "samtools index {input}"

rule count_mapped_reads:
    input:
        "alignment_{sample}.sorted.bam"
    output:
        "mapped_reads_{sample}.txt"
    script:
        "count_mapped_reads.py"
