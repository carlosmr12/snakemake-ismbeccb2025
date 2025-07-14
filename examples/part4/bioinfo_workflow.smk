from snakemake.io import glob_wildcards

# Dynamically determine the list of samples from the reads files
SAMPLES, = glob_wildcards("../reads/{sample}.fasta")

# Define the subworkflow for indexing the reference genome
subworkflow index_workflow:
    workdir:
        "index_dir"
    snakefile:
        "index_workflow.smk"

# Include per-sample processing rules
include: "rules.smk"

rule all:
    input:
        expand("mapped_reads_{sample}.txt", sample=SAMPLES)
