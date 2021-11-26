library(quantmod)
library(tidyquant)

load_data_from_csv_files = function(data_dir){
  # List all files present in the stocks directory
  files = list.files(paste(data_dir, "/stocks", sep=""))
  names = sub("\\.csv", "", files)
  
  # Initialize a data frame
  data = read.zoo(
    paste(data_dir, "/stocks/", files[1], sep=""),
    header = TRUE
  )
  df = as.data.frame(data)
  colnames(df) <- c(names[1])
  
  # Fill the data frame
  for (i in 2:length(files)){
    data = read.zoo(
      paste(data_dir, "/stocks/", files[i], sep=""),
      header = TRUE
    )
    df[names[i]] = as.data.frame(data)
  }
  
  return(df)
}

compute_log_return_matrix = function(df){
  # Create a copy of the data frame
  log_return_df = data.frame(df)
  
  # Compute the log-return for all rows
  for (i in 2:nrow(log_return_df)){
    log_return_df[i,] = log(df[i,] / df[i-1,])
  }
  
  # Remove the first row as t-1 does not exist
  log_return_df = log_return_df[-1,]
  
  return(log_return_df)
}