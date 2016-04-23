library(shiny)
library(wordcloud)
library(stringr)
source("prediction.R")

load("bigramDF.RData")
load("trigramDF.RData")
load("fourgramDF.RData")

shinyServer
(
    function(input,output,session)
    {
        observeEvent(input$text,{
            pred <- runPrediction(input$text)
            if(!is.null(pred) & dim(pred)[1] > 0){
                pred <- filter(pred[1:30,],!is.na(nextWord))
                words <<- pred$nextWord
                
                output$word1 <- renderUI({ actionButton("action1", label = pred$nextWord[1]) })
                output$word2 <- renderUI({ actionButton("action2", label = pred$nextWord[2]) })
                output$word3 <- renderUI({ actionButton("action3", label = pred$nextWord[3]) })
                
                output$predictedWords <- renderDataTable({pred})    
                
                output$wordCloud <- renderPlot({
                    wordcloud(pred$nextWord, pred$mle, scale=c(6,1), random.order=FALSE, use.r.layout = FALSE, rot.per = 0.35,
                                  colors=brewer.pal(8, "Dark2"), random.color = TRUE, max.words = dim(pred)[1])
                })
            }
        })

        observeEvent(input$action1, {
            updateTextInput(session,"text", value = paste(str_trim(input$text), words[1], sep=" "))
        })
        observeEvent(input$action2, {
            updateTextInput(session,"text", value = paste(str_trim(input$text), words[2], sep=" "))
        })
        observeEvent(input$action3, {
            updateTextInput(session,"text", value = paste(str_trim(input$text), words[3], sep=" "))
        })
        
        observe({
            toggle(id = "predictedWords", condition = input$checkTable)
            toggle(id = "wordCloud", condition = input$checkCloud)
        })
        
    }
)