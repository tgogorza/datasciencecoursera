plot1 <- function(){
  source("LoadData.R")
  data <- LoadData()
  
  plot <- hist(data$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.copy(png,'plot1.png')
  dev.off()
}