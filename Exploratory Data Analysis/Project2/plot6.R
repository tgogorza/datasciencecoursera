library(dplyr)
library(ggplot2)

#Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Factor variables
NEI <- mutate(NEI, year = factor(year))

#Filter Baltimore and LA data
filteredData <- filter(NEI,fips == "24510" | fips == "06037")

#Plot 5
motor <- grep("+vehicle+",SCC$EI.Sector,ignore.case=TRUE)
motorcategories <- SCC$SCC[motor]
#Filter NEI set by SCC coal categories
motorNEI <- filter(filteredData, SCC %in% motorcategories)
#Add city name
motorNEI <- mutate(motorNEI, city = ifelse(fips == "24510", "Baltimore", "LA"))
qplot(year,Emissions,data=motorNEI, facets = .~city) + stat_summary(fun.y = sum, geom="bar") + labs(title = "Motor Vehicle Emissions (Baltimore vs LA)")
ggsave("plot6.png")