plot4 <- function(){
  source("LoadData.R")

  #Get data
  data <- LoadData()
  #Add week days column to data set 
  data <- mutate(data,wday = wday(dmy(Date), label=TRUE)) 
  
  par(mfrow = c(2,2))
  par(cex.lab = 0.75)
  par(cex.axis = 0.75)
  
  #Plot1
  plot(x= 1:nrow(data), y=data$Global_active_power,type="n", xaxt="n", xlab="", ylab="Global Active Power")
  lines(x= 1:nrow(data), y=data$Global_active_power)
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  
  #Plot2
  plot(x= 1:nrow(data), y=data$Voltage, xaxt="n", xlab="datetime", ylab="Voltage", type = "l")
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  
  #Plot3
  plot(x= 1:nrow(data), y=data$Sub_metering_1, type="n", xaxt="n", xlab="", ylab="Energy sub metering")
  lines(x= 1:nrow(data), y=data$Sub_metering_1, type="l")
  lines(x= 1:nrow(data), y=data$Sub_metering_2, type="l", col = "red")
  lines(x= 1:nrow(data), y=data$Sub_metering_3, type="l", col = "blue")
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  legend("topright", lwd=1, col = c("black", "blue", "red"), legend = c(names(data[7]),names(data[8]),names(data[9])), bty="n", cex = 0.7)
  
  #Plot4
  plot(x= 1:nrow(data), y=data$Global_reactive_power, xaxt="n", xlab="datetime", ylab="Global_reactive_power", type = "l")
  axis(1, at = c(1,nrow(data)/2,nrow(data)), labels = c("Thu","Fri","Sat"))
  
  dev.copy(png,'plot4.png')
  dev.off()
}