library(shiny)
library(ggplot2)
library(gridExtra)
shinyServer
(
    function(input,output)
    {
        emg <- head(read.csv("data/emg.csv"),500)
        orient <- head(read.csv("data/orientationEuler.csv"),500)
        accelerometer <- head(read.csv("data/accelerometer.csv"),500)
        gyro <- head(read.csv("data/gyro.csv"),500)
        
        curData <- reactive({
            switch(input$selection,
                EMG = {emg}, 
                Rotation = {orient},
                Accelerometer = {accelerometer},
                Gyro = {gyro})
        }) 
#         letters <- reactive( { as.numeric(charToRaw(input$text)) } )
#         output$convertedText <- renderText({
#             c("Your Name in Numbers: ", letters())
#         })

        output$plot <- renderPlot({
            plist <- vector("list",dim(curData())[2]-1)
            for (i in 2:(dim(curData())[2])) {
                dat <- data.frame(timestamp = curData()[,1], data = curData()[,i])
                p <- ggplot(dat,aes(timestamp,data)) + geom_point() + stat_smooth() + xlab("time") + ylab(names(curData())[i])
                plist[[i-1]] <- p
            }
            n <- length(plist)
            nCol <- floor(sqrt(n))
            do.call("grid.arrange", c(plist, ncol=nCol))
            
        })
    }
)