import pandas as pd
from sklearn.metrics import accuracy_score
import joblib

df = pd.read_csv(snakemake.input.data)
# Exclude non-numeric 'species' column
X_test = df.drop(['target', 'species'], axis=1)
y_test = df['target']
model = joblib.load(snakemake.input.model)
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
with open(snakemake.output[0], "w") as f:
    f.write(f"Accuracy: {accuracy}")
