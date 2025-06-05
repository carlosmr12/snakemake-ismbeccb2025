from snakemake.io import glob_wildcards

# Dynamically determine the list of samples from the reads files
SAMPLES, = glob_wildcards("../reads/{sample}.fasta")

rule all:
    input:
        "report.txt"

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
        temp("alignment_{sample}.sam")
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
        temp("mapped_reads_{sample}.txt")
    script:
        "count_mapped_reads.py"

rule generate_report:
    input:
        expand("mapped_reads_{sample}.txt", sample=SAMPLES)
    output:
        protected("report.txt")
    run:
        with open(output[0], "w") as report:
            for infile in input:
                # Extract sample name from filename (assumes format: mapped_reads_{sample}.txt)
                sample = infile.split("_")[2].split(".")[0]
                with open(infile) as f:
                    count = f.read().strip()
                report.write(f"{sample}: {count}\n")
