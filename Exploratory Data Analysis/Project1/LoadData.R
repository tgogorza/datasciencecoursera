LoadData <- function(){
  library(dplyr)
  
  data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec=".", nrows= 1)
  names <- names(data)
  data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec=".", skip = 66636, nrows= 2880,na.strings = "?")
  names(data) <- names
  return(data)
}