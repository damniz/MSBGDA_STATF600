library(quantmod)
library(tidyquant)

source("tools.R")
data_dir = "./data"

# Load all CSV files into a single data frame
df = load_data_from_csv_files(data_dir)

# Compute the log-return data frame
log_return_df = compute_log_return_matrix(df)

# Compute the Kendall's Tau Correlation Matrix
kendall_corr_matrix = kendall_tau_correlation_matrix(log_return_df)
