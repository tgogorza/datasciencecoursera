library(ggplot2)
data("ToothGrowth")
data <- as.data.frame(ToothGrowth)
summary(data)

ggplot(data,aes(factor(dose),len)) + geom_point(stat = "identity") + 
    facet_grid(.~supp) +  
    labs(title="Dose vs Supp by Suplement Type", y="Length", x="Dose")


