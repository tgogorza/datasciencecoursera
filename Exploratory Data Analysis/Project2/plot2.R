library(dplyr)

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
emissionsPerYearBaltimore <- summarise(baltimoreData, sum = sum(Emissions))

#Plot 2
barplot(emissionsPerYearBaltimore$sum, main="Emissions per year (Baltimore)", names.arg = emissionsPerYearBaltimore$year)
dev.copy(png,'plot2.png')
dev.off()