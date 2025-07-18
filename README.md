# Pairwise Correlation Network Analysis



This repository contains **`pairwise_correlation_network_analysis.R`**, a self-contained R script that builds a gene-to-gene correlation network from an expression matrix. All user settings sit at the top of the script so you can point it at any data set and adjust thresholds without touching the logic.

---

## Folder overview

| Folder       | Purpose                                                     |
|--------------|-------------------------------------------------------------|
| `data/`      | Input files, for example `expression_matrix.csv`             |
| `scripts/`   | The analysis script and any helper functions (this folder)  |
| `results/`   | Edge list CSV and Excel summary created by the script       |
| `notebooks/` | Optional notebooks for extra visualisation                  |

Feel free to rename or reorganise; the script uses explicit paths that you can change in one place.

---

## Requirements

| Software | Version tested | Install command |
|----------|----------------|-----------------|
| R        | 4.2 or newer   | <https://cran.r-project.org/> |
| readr    | 2.1            | `install.packages("readr")` |
| dplyr    | 1.1            | `install.packages("dplyr")` |
| writexl  | 1.4            | `install.packages("writexl")` |


---

## Quick start

```bash
# clone the repository
git clone https://github.com/Abtint/Pairwise-Correlation-Network-Analysis.git
cd Pairwise-Correlation-Network-Analysis

# make the script executable (once)
chmod +x scripts/pairwise_correlation_network_analysis.R

# run with the default settings
./scripts/pairwise_correlation_network_analysis.R
```
---

## Key parameters (edit in the script header) 
| Parameter        | Meaning                       | Example                              |
| ---------------- | ----------------------------- | ------------------------------------ |
| `EXPR_FILE`      | Path to expression matrix CSV | `"data/expression_matrix.csv"`       |
| `META_FILE`      | Optional sample metadata file | `"data/metadata.csv"`                |
| `COR_METHOD`     | `"pearson"` or `"spearman"`   | `"pearson"`                          |
| `THRESHOLD`      | Absolute correlation cut-off  | `0.70`                               |
| `OUT_EDGES_CSV`  | Edge list output file         | `"results/strong_cor_edges.csv"`     |
| `OUT_SUMMARY_XL` | Summary metrics file          | `"results/correlation_summary.xlsx"` |

---

## Output files
| File                       | Description                                           |
| -------------------------- | ----------------------------------------------------- |
| `strong_cor_edges.csv`     | Edge list (Gene1, Gene2, Correlation) for network use |
| `correlation_summary.xlsx` | Four-row Excel sheet with metrics for your notebook   |
| Console log                | Basic counts printed to the terminal                  |

---

## Tips for large data sets
Pre-filter low-variance or low-expression genes before running the script to save memory.

Increase R memory limit on Windows with memory.limit().

Consider running on a server with at least 32 GB RAM for matrices with more than twenty thousand genes.

---

## License
Distributed under the MIT License 

---

## Citation
https://github.com/Abtint/Pairwise-Correlation-Network-Analysis

