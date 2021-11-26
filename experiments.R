library(quantmod)
library(tidyquant)

source("tools.R")
data_dir = "./data"


df = load_data_from_csv_files(data_dir)
log_return_df = compute_log_return_matrix(df)
