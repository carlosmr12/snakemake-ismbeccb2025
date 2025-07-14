import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import joblib

df = pd.read_csv(snakemake.input.data)
# Exclude non-numeric 'species' column
X = df.drop(['target', 'species'], axis=1)
y = df['target']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
model = joblib.load(snakemake.input.model)
y_pred = model.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
with open(snakemake.output[0], "w") as f:
    f.write(f"Accuracy: {accuracy}")
