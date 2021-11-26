library(quantmod)
library(tidyquant)

data_dir = "./data"

# List all files present in the stocks directory
files = list.files(paste(data_dir, "/stocks", sep=""))
names = sub("\\.csv", "", files)

# Initialize a frame
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
