library(ggplot2)
library(dplyr)

data("ToothGrowth")
data <- as.data.frame(ToothGrowth)
summary(data)

ggplot(data,aes(factor(dose),len)) + geom_point(stat = "identity") + facet_grid(.~supp) +  
    labs(title="Dose vs Supp by Suplement Type", y="Length", x="Dose")

ggplot(data, aes(x=factor(dose),y=len)) + geom_boxplot() + facet_grid(.~supp) + 
    labs(title="Dose vs Length by Suplement Type", y="Length", x="Dose")

sdoseoj <- select(filter(data, supp == "OJ" & dose==0.5),len)
sdosevc <- select(filter(data, supp == "VC" & dose==0.5),len)
smalltest <- t.test(sdoseoj,sdosevc,paired = FALSE,var.equal = FALSE)
smalltest$conf.int
smalltest$p.value

mdoseoj <- select(filter(data, supp == "OJ" & dose==1),len)
mdosevc <- select(filter(data, supp == "VC" & dose==1),len)
medtest <- t.test(mdoseoj,mdosevc,paired = FALSE,var.equal = FALSE)
medtest$conf.int
medtest$p.value

ldoseoj <- select(filter(data, supp == "OJ" & dose==2),len)
ldosevc <- select(filter(data, supp == "VC" & dose==2),len)
largetest <- t.test(ldoseoj,ldosevc,paired = FALSE,var.equal = FALSE)
largetest$conf.int
largetest$p.value

#sdose <- rbind(sdoseoj,sdosevc)
#mdose <- rbind(mdoseoj,mdosevc)
#ldose <- rbind(ldoseoj,ldosevc)
