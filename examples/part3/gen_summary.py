import pandas as pd
import os

# Get input files and output file from Snakemake
input_files = snakemake.input
output_file = snakemake.output[0]

# Initialize a list to store data
data = []

# Process each input file
for file in input_files:
    # Extract sample name from filename
    sample = os.path.basename(file).replace("mapped_reads_", "").replace(".txt", "")
    # Read the content (assuming a single value per file)
    with open(file, 'r') as f:
        count = f.read().strip()
    data.append({'Sample': sample, 'Mapped_Reads': count})

# Create a DataFrame and save to output
df = pd.DataFrame(data)
df.to_csv(output_file, sep='\t', index=False)
