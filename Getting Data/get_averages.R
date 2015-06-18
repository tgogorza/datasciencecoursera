library(dplyr)
#Load data
data <- read.csv("clean_data.csv")
#Get averages groupes by subject and activity
groupeddata <- group_by(data,activity,subject)
averages <- summarise_each(groupeddata,funs(mean))

#Save data to CSV file
write.csv(averages,"grouped_averages.csv")
