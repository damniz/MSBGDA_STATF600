library(quantmod)
library(tidyquant)

data_dir = "./data"

files = list.files(paste(data_dir, "/stocks", sep=""))
print(files)

for (file in files){
  data = read.zoo(
    paste(data_dir, "/stocks/", file, sep=""),
    header = TRUE
  )
}