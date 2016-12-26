#NextWord
##Text Predictor
https://tgogorza.shinyapps.io/WordPredictor/

This is the final project of the Coursera.org Data Science specialization.
The goal of the project is to create a text predictor, which will take an incomplete phrase as an input and will a list of suggestions for the next word.

The project uses a set of phrases extracted from blogs, news and tweeter. The data set can be found at https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip .

###Repo content
- **cleanData.R** : set of functions used to clean the corpus, remove symbols, convert to lower case, tokenize, etc
- **createModel.R** : set of functions used to create N-gram language models
- **exploratoryAnalysis.R** : script used to analyze the corpus and understand the problem
- **loadData.R** : set of functions used to load the data from text files
- **train.R** : script used to create the corpus, and the models
- ShinyApp : 
  - **bigramDF.RData** : 2-Gram language model
  - **trigramDF.RData** : 3-Gram language model
  - **fourgramDF.RData** : 4-Gram language model
  - **prediction.R** : script used to run the prediction algorithm
  - **global.R** : global functions and data for the Shiny app
  - **server.R** : server operations of Shiny app
  - **ui.R** : UI definition of Shiny app
- Slides
  - **presentation.Rpres** : Set of slides
