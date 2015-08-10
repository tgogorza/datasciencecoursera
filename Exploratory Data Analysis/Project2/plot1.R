#Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Factor variables 
NEI <- mutate(NEI, year = factor(year))

#Get sum of emissions per year
perYear <- group_by(NEI,year)
emissionsPerYear <- summarise(perYear, sum = sum(Emissions))

#Plot 1
barplot(emissionsPerYear$sum, main="Emissions per year", names.arg = emissionsPerYear$year)
dev.copy(png,'plot1.png')
dev.off()