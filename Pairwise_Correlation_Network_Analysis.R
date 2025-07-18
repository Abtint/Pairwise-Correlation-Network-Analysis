#!/usr/bin/env Rscript
# ------------------------------------------------------------
# Pairwise Correlation Network Analysis – GENERAL TEMPLATE
# ------------------------------------------------------------
# • Computes pairwise Pearson (or Spearman) correlations
# • Filters by an absolute-value threshold
# • Saves an edge list for network tools (Cytoscape, igraph, etc.)
# • Writes a small XLSX summary for your lab notebook
# ------------------------------------------------------------

# ============================================================
# 1 ·  User-defined settings
# ============================================================
EXPR_FILE      <- "expression_matrix.csv"   # rows = genes, cols = samples
META_FILE      <- "sample_metadata.csv"     # optional – only used to re-order
COR_METHOD     <- "pearson"                 # "pearson" or "spearman"
THRESHOLD      <- 0.70                      # |r| cut-off
OUT_EDGES_CSV  <- "strong_cor_edges.csv"
OUT_SUMMARY_XL <- "correlation_summary.xlsx"

# ============================================================
# 2 ·  Libraries
# ============================================================
suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(writexl)
})

# ============================================================
# 3 ·  Load expression matrix  (genes × samples)
# ============================================================
expr <- read_csv(EXPR_FILE, show_col_types = FALSE)
expr <- as.data.frame(expr)
rownames(expr) <- expr[[1]]          # first column = gene names
expr[[1]]    <- NULL

# Optional: ensure column order matches metadata (if provided)
if (file.exists(META_FILE)) {
  meta  <- read_csv(META_FILE, show_col_types = FALSE)
  expr  <- expr[ , meta$Sample, drop = FALSE]
}

# ============================================================
# 4 ·  Correlation calculation  (transposed: genes as variables)
# ============================================================
cor_mat <- cor(t(expr), method = COR_METHOD)

# ============================================================
# 5 ·  Convert to long format and filter
# ============================================================
edges <- as.data.frame(as.table(cor_mat))
names(edges) <- c("Gene1", "Gene2", "Correlation")

edges <- edges |>
  filter(Gene1 != Gene2) |>
  filter(abs(Correlation) >= THRESHOLD)

write_csv(edges, OUT_EDGES_CSV)

# ============================================================
# 6 ·  Summary metrics
# ============================================================
n_genes     <- nrow(expr)
total_pairs <- n_genes * (n_genes - 1)
strong_pairs<- nrow(edges)

summary_tbl <- tibble(
  Metric      = c("Total genes analysed",
                  "Total gene pairs assessed",
                  paste0("Strong pairs |r| ≥ ", THRESHOLD),
                  "Proportion of strong pairs"),
  Value       = c(n_genes,
                  total_pairs,
                  strong_pairs,
                  sprintf("%.2f %%", 100 * strong_pairs / total_pairs))
)

write_xlsx(summary_tbl, OUT_SUMMARY_XL)

# ============================================================
# 7 ·  Console log
# ============================================================
cat("=== Pairwise correlation analysis completed ===\n")
cat("   Genes analysed           :", n_genes, "\n")
cat("   Strongly co-expressed    :", strong_pairs, "\n")
cat("   Edge list written to     :", OUT_EDGES_CSV, "\n")
cat("   Summary written to       :", OUT_SUMMARY_XL, "\n")
