library(shiny)
shinyUI
(
    fluidPage(
        titlePanel("Myo Armband Reader"),        
        pageWithSidebar
        (
            headerPanel
            (
                h5("This page loads sample data read from a Myo Armband and lets the user select a sensor type to read the captured data in the form of scatter plots and a smoother line")
            ),
            sidebarPanel
            (
                radioButtons("selection","Sensors",c("Rotation","EMG","Accelerometer","Gyro"),"Rotation")
            ),
            mainPanel
            (
                plotOutput("plot")
            )
        )
    )
    
)