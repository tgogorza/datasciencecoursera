library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyjs)

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Predictor", tabName = "predictor", icon = icon("th")),
        menuItem("Options", icon = icon("th"), tabName = "options"),
        menuItem("Information", icon = icon("th"), tabName = "information")
    )
)

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "predictor",
            h2("Word Predictor"),
            fluidPage(theme = shinytheme("spacelab"),
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
                          column(width=1, offset=2, uiOutput("word1")),
                          column(width=1, offset=2, uiOutput("word2")),
                          column(width=1, offset=2, uiOutput("word3"))
                              ),
                      br(),
                      plotOutput("wordCloud"),
                      br(),
                      dataTableOutput("predictedWords")
                  )
              )
          )
        ),
        
        tabItem(tabName = "options",
                h2("Options"),
                useShinyjs(),
                checkboxInput("checkCloud", "Show predicted words cloud", TRUE),
                checkboxInput("checkTable", "Show predicted words table", FALSE)
        ),
        tabItem(tabName = "information",
                h2("How to use..."),
                h5("Simply start typing in the text input area and the application will return a list of suggestions for the next word."),
                h2("Top suggestions..."),
                h5("The 3 most likely words will be shown as buttons below the text area. You can click on those to automatically add them to your text."),
                h2("Word cloud..."),
                h5("You can also use the word cloud to check for word suggestions. The cloud will show the best suggestions varying sizes according to likelyhood."),
                h2("Word table..."),
                h5("You will also find a table with predicted words and more information internally used by the application for predicting words.")
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "NextWord"),
    sidebar,
    body
)

#shinyUI
#(

# 
#     fluidPage(theme = shinytheme("spacelab"),
#         titlePanel("Word Predictor"),        
#         fluidPage
#         (
#             fluidRow
#             (
#                 h5("Behold the mind reading next word predictor! Enter a phrase and let the magic begin!")
#             ),
#             mainPanel
#             (
#                 textInput("text", "Enter a phrase", "",width = "100%"),
#                 fluidRow(
#                     column(width=1, offset=1, uiOutput("word1")),
#                     column(width=1, offset=1, uiOutput("word2")),
#                     column(width=1, offset=1, uiOutput("word3"))
#                         ),
#                 br(),
#                 tableOutput("predictedWords")
#             )
#         )
#     )
#     
#)