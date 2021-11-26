library(quantmod)
library(tidyquant)


data_dir = "./data"
data_start = "2012-01-31"
date_end = "2017-01-31"
n_days = 1258


sp500 = read.csv(paste(data_dir, "/S&P500_SharedConstituents.csv", sep=""))
print(head(sp500))

for (i in 1:nrow(sp500)){
  symbol = sp500$Symbol[i]
  
  tryCatch({
    data = getSymbols(
      symbol,
      from = data_start,
      to = date_end,
      warnings = TRUE,
      auto.assign = FALSE
    )
    
    names(data) = sub("^.*\\.", "", names(data))
    
    if (nrow(data) == n_days){
      write.zoo(
        data$Close,
        paste(data_dir, "/stocks/", symbol, ".csv", sep=""),
      )
      print(paste("Data downloaded and exported for:", symbol, "->", i, sep=" "))
    } else {
      print(paste("Data downloaded but not enough rows for:", symbol, "->", i, sep=" "))
    }
    
  }, error = function(e) {
      print(paste("Error downloading data for:", symbol, "->", i, sep=" "))
    }
  )
}
