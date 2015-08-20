library(dplyr)
library(ggplot2)

#Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Factor variables
NEI <- mutate(NEI, year = factor(year))
NEI <- mutate(NEI, type = factor(type))

#Get sum of emissions per year for Baltimore
perYear <- group_by(NEI,year)
#Filter Baltimore data
baltimoreData <- filter(perYear,fips == "24510")

#Plot 3
png("plot3.png",width = 640, height = 480)
qplot(year, Emissions, data=baltimoreData, facets = .~type) + stat_summary(fun.y = sum, geom = "bar") + labs(title = "Emissions by type")
dev.off()