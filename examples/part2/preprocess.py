import pandas as pd

df = pd.read_csv(snakemake.input[0])
df['target'] = df['species'].map({'setosa': 0, 'versicolor': 1, 'virginica': 2})
df.to_csv(snakemake.output[0], index=False)
