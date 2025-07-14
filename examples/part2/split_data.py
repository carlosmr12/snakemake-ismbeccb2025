import pandas as pd
from sklearn.model_selection import train_test_split
import sys

test_size = float(snakemake.params.test_size)

df = pd.read_csv(snakemake.input.data)
# Exclude non-numeric 'species' column
X = df.drop(['target', 'species'], axis=1)
y = df['target']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=test_size, random_state=42)
df_test = pd.concat([X_test, y_test], axis=1)
df_test.to_csv('test.csv', index=False)
print(f"Data splitted:\t{df_test.shape}")
