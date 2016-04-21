library(shiny)
library(wordcloud)
source("prediction.R")

load("bigramDF.RData")
load("trigramDF.RData")
load("fourgramDF.RData")

shinyServer
(
    function(input,output)
    {
        observeEvent(input$text,{
            pred <- runPrediction(input$text)
            if(!is.null(pred) & dim(pred)[1] > 0){
                pred <- filter(pred[1:30,],!is.na(nextWord))
                output$word1 <- renderUI({
                    actionButton("action1", label = pred$nextWord[1])
                })
                output$word2 <- renderUI({
                    actionButton("action2", label = pred$nextWord[2])
                })
                output$word3 <- renderUI({
                    actionButton("action3", label = pred$nextWord[3])
                })
                output$predictedWords <- renderDataTable({pred})    
                
                output$wordCloud <- renderPlot({
                    wordcloud(pred$nextWord, pred$mle, scale=c(6,1), random.order=FALSE, use.r.layout = FALSE, rot.per = 0.35,
                                  colors=brewer.pal(8, "Dark2"), random.color = TRUE, max.words = dim(pred)[1])
                })
            }
        })
        
        observe({
            toggle(id = "predictedWords", condition = input$checkTable)
            toggle(id = "wordCloud", condition = input$checkCloud)
        })
        
    }
)