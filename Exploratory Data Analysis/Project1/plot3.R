plot3 <- function(){
  source("LoadData.R")
  library(lubridate)
  
  data <- LoadData()
  #Add week days column to data set 
  data <- mutate(data,wday = wday(dmy(Date), label=TRUE)) 
  #Draw plot
  #plot(x= 1:nrow(data), y=data$Sub_metering_1, type="n", ylab="Global Active Power (kilowatts)", xaxt="n", xlab="")
  #line(x= 1:nrow(data), y=data$Sub_metering_1, type="l", ylab="Global Active Power (kilowatts)", xaxt="n", xlab="")
  #plot(x= 1:nrow(data), y=data$Sub_metering_2, type="l", ylab="Global Active Power (kilowatts)", xaxt="n", xlab="", col = "red")
  #plot(x= 1:nrow(data), y=data$Sub_metering_3, type="l", ylab="Global Active Power (kilowatts)", xaxt="n", xlab="", col = "blue")
  
  plot(x= 1:nrow(data), y=data$Sub_metering_1, type="n", xaxt="n", xlab="", ylab="Energy sub metering")
  lines(x= 1:nrow(data), y=data$Sub_metering_1, type="l")
  lines(x= 1:nrow(data), y=data$Sub_metering_2, type="l", col = "red")
  lines(x= 1:nrow(data), y=data$Sub_metering_3, type="l", col = "blue")
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  legend("topright", lwd=1, col = c("black", "blue", "red"), legend = c(names(data[7]),names(data[8]),names(data[9])), cex=0.7, inset=0) 
  
  dev.copy(png,'plot3.png')
  dev.off()
}