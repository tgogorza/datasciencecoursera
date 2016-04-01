require(quanteda)
require(stringr)

prediction <- function(phrase,model,grams){
    #Preprocess input phrase
    tokens <- tokenize(phrase,what = "word", removeNumbers = TRUE, removePunct = TRUE,
                       removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE)
    tokens <- removeFeatures(tokens,stopwords("english"))[[1]]
    
    elements <- grams - 2
    tokens <- tokens[(length(tokens) - elements):length(tokens)]
    input <- paste(c(tokens,""), collapse = "_")
    
    phrases <- filter(model, str_detect(gram,input))
    total <- sum(phrases$count)
    phrases <- mutate(phrases,mle = count / total)
    phrases[1:20,c(paste("word",grams,sep=""),"mle")]
}

