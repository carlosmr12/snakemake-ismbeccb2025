# Snakefile for bioinformatics workflow

rule all:
    input:
        "mapped_reads.txt"

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
        reads="reads.fasta"
    output:
        "alignment.sam"
    shell:
        "bwa mem reference.fasta {input.reads} > {output}"

rule sort_alignment:
    input:
        "alignment.sam"
    output:
        "alignment.sorted.bam"
    shell:
        "samtools sort {input} -o {output}"

rule index_alignment:
    input:
        "alignment.sorted.bam"
    output:
        "alignment.sorted.bam.bai"
    shell:
        "samtools index {input}"

rule count_mapped_reads:
    input:
        "alignment.sorted.bam"
    output:
        "mapped_reads.txt"
    script:
        "count_mapped_reads.py"
