library(shiny)
library(ggplot2)

shinyServer
(
    function(input,output)
    {
        load("bigramDF.RData")
        load("trigramDF.RData")
        load("fourgramDF.RData")

        #models <- data.frame(bigrams,trigrams,fourgrams)
        # This will change the value of input$inText, based on x
        #updateTextInput(session, "inText", value = paste("New text", x))
        
#         pred <- reactive({
#             runPrediction("hey ho let's",models)
#         })
        
        observeEvent(input$button,{
            pred <- runPrediction(input$text)
            output$word1 <- renderUI({
                actionButton("action", label = pred$nextWord[1])
            })
            output$word2 <- renderUI({
                actionButton("action", label = pred$nextWord[2])
            })
            output$word3 <- renderUI({
                actionButton("action", label = pred$nextWord[3])
            })
                        
            
#             output$word1 <- renderText({pred$nextWord[1]})
#             output$word2 <- renderText({pred$nextWord[2]})
#             output$word3 <- renderText({pred$nextWord[3]})
            output$predictedWords <- renderTable(pred)
        })
            
        observeEvent(input$text,{
            pred <- runPrediction(input$text)
            if(!is.null(pred) & dim(pred)[1] > 0){
                output$word1 <- renderUI({
                    actionButton("action", label = pred$nextWord[1])
                })
                output$word2 <- renderUI({
                    actionButton("action", label = pred$nextWord[2])
                })
                output$word3 <- renderUI({
                    actionButton("action", label = pred$nextWord[3])
                })
                output$predictedWords <- renderTable(pred)    
            }
            
        })
        
#         letters <- reactive( { as.numeric(charToRaw(input$text)) } )
#         output$convertedText <- renderText({
#             c("Your Name in Numbers: ", letters())
#         })

        
    }
)