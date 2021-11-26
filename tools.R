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
  message("CSV files loaded into data frame.")
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
  
  message("Log-Return matrix computed.")
  return(log_return_df)
}

kendall_tau_correlation_matrix = function(df){
  # Compute Kendall's Tau coefficient according to equation 3.3
  n = nrow(df)
  d = ncol(df)
  res = matrix(0, ncol=d, nrow=d)
  
  for (j in 1:d){
    for (k in 1:d){
      message("Kendall's Tau - d: ", d, " - j: ", j, " - k: ", k)
      tau = 0
      for (iprime in 2:n){
        for (i in 1:(iprime-1)){
          tau <- tau + ( sign(df[i,j] - df[iprime,j]) * sign(df[i,k] - df[iprime,k]) )
        }
      }
      tau = (2*tau) / (n * (n-1))
      res[j, k] = sin( (pi/2) * tau)
    }
    # message('Kendall\'s Tau Correlation Matrix: Processing ', j, ' of ', d)
  }
  return(res)
}
