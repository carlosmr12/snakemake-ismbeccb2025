rule index_reference:
    input:
        "output/reference.fasta"
    output:
        "output/reference.index.done"
    shell:
        "bwa index {input} && touch {output}"
