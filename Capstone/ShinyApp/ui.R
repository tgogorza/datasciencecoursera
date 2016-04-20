library(shiny)
shinyUI
(
    fluidPage(
        titlePanel("Word Predictor"),        
        fluidPage
        (
            fluidRow
            (
                h5("Behold the mind reading next word predictor! Enter a phrase and let the magic begin!")
            ),
            mainPanel
            (
                textInput("text", "Enter a phrase", "",width = "100%"),
                fluidRow(
                    column(width=1, offset=1, uiOutput("word1")),
                    column(width=1, offset=1, uiOutput("word2")),
                    column(width=1, offset=1, uiOutput("word3"))
                        ),
                br(),
                tableOutput("predictedWords")
            )
        )
    )
    
)