# Bioinformatics workflow

## Exercise 1: Add filtering step

- **input**: alignment.sorted.bam
```
samtools view -q 20 -b {input} > {output}
```

Challenge: Add quality filtering and make the threshold configurable

```
samtools view -q {params.quality_threshold} -b {input} > {output}
```

## Exercise 2: Generate Summary Statistics (can these run in parallel?)

- **input**: alignment.sorted.bam

```
samtools flagstat {input} > {output}
```

Variation:

```
samtools view -q {params.quality_threshold} -b {input} > {output}
```
