library(dplyr)
library(ggplot2)

#Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Factor variables 
NEI <- mutate(NEI, year = factor(year))

#Plot 4
coal <- grep("^fuel comb -(.*)- coal$", SCC$EI.Sector, ignore.case=TRUE)
coalcategories <- SCC$SCC[coal]
#Filter NEI set by SCC coal categories
coalNEI <- filter(NEI, SCC %in% coalcategories)

png("plot4.png",width = 480, height = 480)
qplot(year,Emissions,data=coalNEI) + stat_summary(fun.y = sum, geom="bar") + labs(title = "Coal Combustion Emissions")
dev.off()