import pysam

bam = pysam.AlignmentFile(snakemake.input[0], "rb")
count = 0
for read in bam:
    if not read.is_unmapped:
        count += 1
with open(snakemake.output[0], "w") as f:
    f.write(str(count))
