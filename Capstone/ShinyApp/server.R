library(shiny)
library(ggplot2)
source("prediction.R")

shinyServer
(
    function(input,output)
    {
        bigrams <- load("bigramDF.RData")
        trigrams <- load("trigramDF.RData")
        fourgrams <- load("fourgramDF.RData")
        
        models <- data.frame(bigrams,trigrams,fourgrams)
        # This will change the value of input$inText, based on x
        #updateTextInput(session, "inText", value = paste("New text", x))
        
#         pred <- reactive({
#             runPrediction("hey ho let's",models)
#         })
        
        observeEvent(input$text,{
            pred <- runPrediction(input$text,models)
            output$predictedWords <- renderTable(pred)
        })
            
        
#         letters <- reactive( { as.numeric(charToRaw(input$text)) } )
#         output$convertedText <- renderText({
#             c("Your Name in Numbers: ", letters())
#         })

        
    }
)