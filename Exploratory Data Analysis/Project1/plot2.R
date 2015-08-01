plot2 <- function(){
  source("LoadData.R")
  library(lubridate)
  
  data <- LoadData()
  #Add week days column to data set 
  data <- mutate(data,wday = wday(dmy(Date), label=TRUE)) 
  #Draw plot
  plot(x= 1:nrow(data), y=data$Global_active_power,type="n", xaxt="n", xlab="", ylab="Global Active Power (kilowatts)")
  lines(x= 1:nrow(data), y=data$Global_active_power)
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  
  dev.copy(png,'plot2.png')
  dev.off()
}