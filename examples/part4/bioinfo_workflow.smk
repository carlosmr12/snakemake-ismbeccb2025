from snakemake.io import glob_wildcards

# Dynamically determine the list of samples from the reads files
SAMPLES, = glob_wildcards("../reads/{sample}.fasta")

# Define the subworkflow for indexing the reference genome
module index_workflow:
    workdir:
        "output"
    snakefile:
        "index_workflow.smk"

# Include per-sample processing rules
include: "rules.smk"

rule all:
    input:
        "output/reference.index.done",
        expand("mapped_reads_{sample}.txt", sample=SAMPLES)
