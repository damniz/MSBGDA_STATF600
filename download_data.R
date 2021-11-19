library(quantmod)
library(tidyquant)

data_dir = "./data"
data_start = "2017-01-01"
date_end = "2021-01-01"


sp500 = read.csv(paste(data_dir, "/S&P500.csv", sep=""))
print(head(sp500))

for (i in 1:nrow(sp500)){
  symbol = sp500$Symbol[i]
  print(paste("Downloading and exporting data for:", symbol, "->", i, sep=" "))
  
  tryCatch({
    data = getSymbols(
      symbol,
      from = data_start,
      to = date_end,
      warnings = TRUE,
      auto.assign = FALSE
    )
    write.csv(data, paste(data_dir, "/", symbol, ".csv", sep=""))
  }, error = function(e) {
      print(paste("Error downloading data for:", symbol, sep=" "))
    }
  )
}