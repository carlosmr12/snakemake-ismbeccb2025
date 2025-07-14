rule index_reference:
    input:
        "output/reference.fasta"
    output:
        "output/reference.index.done"
    log:
        "logs/index_reference.log"
    shell:
        "bwa index {input} && touch {output}"

rule align_reads:
    input:
        index_done="output/reference.index.done",
        reads="../reads/{sample}.fasta"
    output:
        "alignment_{sample}.sam"
    threads: 4
    shell:
        "bwa mem output/reference.fasta {input.reads} > {output}"

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
