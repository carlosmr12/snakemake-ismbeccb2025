# Snakefile for machine learning workflow

rule all:
    input:
        "evaluation.txt"

rule download_data:
    output:
        "iris.csv"
    shell:
        "wget https://raw.githubusercontent.com/mwaskom/seaborn-data/master/iris.csv -O {output}"

rule preprocess_data:
    input:
        "iris.csv"
    output:
        "iris_preprocessed.csv"
    script:
        "preprocess.py"

rule train_model:
    input:
        "iris_preprocessed.csv"
    output:
        "model.pkl"
    script:
        "train.py"

rule evaluate_model:
    input:
        model="model.pkl",
        data="iris_preprocessed.csv"
    output:
        "evaluation.txt"
    script:
        "evaluate.py"
