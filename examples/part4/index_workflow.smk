rule index_reference:
    input:
        "reference.fasta"
    output:
        "reference.index.done"
    shell:
        "bwa index {input} && touch {output}"
