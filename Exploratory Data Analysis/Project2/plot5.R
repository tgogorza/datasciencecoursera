library(dplyr)
library(ggplot2)

#Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Factor variables
NEI <- mutate(NEI, year = factor(year))

#Filter Baltimore data
baltimoreData <- filter(NEI,fips == "24510")

#Plot 5
motor <- grep("+vehicle+",SCC$EI.Sector,ignore.case=TRUE)
motorcategories <- SCC$SCC[motor]
#Filter NEI set by SCC coal categories
motorNEI <- filter(baltimoreData, SCC %in% motorcategories)
png("plot5.png",width = 480, height = 480)
qplot(year,Emissions,data=motorNEI) + stat_summary(fun.y = sum, geom="bar") + labs(title = "Motor Vehicle Emissions (Baltimore)")
dev.off()