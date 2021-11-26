library(quantmod)
library(tidyquant)


data_dir = "./data"
data_start = "2012-01-31"
date_end = "2017-01-31"


data = getSymbols(
  "AAPL",
  from = data_start,
  to = date_end,
  warnings = TRUE,
  auto.assign = FALSE
)
names(data) = sub("^.*\\.", "", names(data))

temp = read.zoo(
  paste(data_dir, "/stocks/AAPL.csv", sep=""),
  header = TRUE
)