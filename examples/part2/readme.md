# ML workflow

## Exercise 1: Add a data splitting rule (train, validation,test)

- **input**: alignment.sorted.bam
```
split_data.py validation=0.2 test=0.1
```

Challenge: Add proportion for each dataset as configurable parameters

```
split_data.py validation={params.validation} test={params.validation}
```
