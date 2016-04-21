require(quanteda)
require(stringr)
require(dplyr)

predictWord <- function(phrase,model){
        
    #Determine ngrams from the model given as parameter
    grams <- str_count(model[1,]$gram,"_") + 1
    wordsInPhrase <- str_count(phrase," ") + 1
    #Check if the phrase is long enough for the model 
    if(wordsInPhrase >= grams - 1){
        phrase <- preprocess(phrase,grams)
        regex <- paste('^', phrase, "_", sep = "")
        phrases <- filter(model, grepl(regex, gram))
        
        #Extract predicted words into a new column
        phrases$nextWord <- sapply(phrases$gram, function(x) tail(str_split(x,"_")[[1]],1) )
        phrases    
    }
    
}

preprocess <- function(phrase, grams){
    
    #Preprocess input phrase
    tokens <- tokenize(phrase,what = "word", removeNumbers = TRUE, removePunct = TRUE,
                       removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE)[[1]]
    #tokens <- removeFeatures(tokens,stopwords("english"))[[1]]
    
    elements <- grams - 2
    tokens <- tokens[(length(tokens) - elements):length(tokens)]

    tokens <- paste(tokens, collapse = "_")
    tokens
}

runPrediction <- function(phrase){
    
    #Try fourgram model first
    pred4 <- predictWord(phrase,fourgrams)
    pred3 <- predictWord(phrase,trigrams)
    pred2 <- predictWord(phrase,bigrams)
    #Combine 3 models and get best 3 probabilities
    #Filter out repeated words
    pred <- NULL
    if(!is.null(pred4)){
        pred <- pred4    
    }
    if(!is.null(pred3)){
        if(!is.null(pred)){
            pred3 <- filter(pred3,!is.na(mle) & !(nextWord %in% pred$nextWord))
            pred <- rbind(pred,pred3)
        }else{
            pred <- pred3
        }
    }
    if(!is.null(pred2)){
        if(!is.null(pred)){
            pred2 <- filter(pred2,!is.na(mle) & !(nextWord %in% pred$nextWord))
            pred <- rbind(pred,pred2)    
        }else{
            pred <- pred2
        }
    }
    
    if(!is.null(pred)){
        #Sort by GT estimators
        pred <- arrange(pred,desc(mle))
        #Filter out invalid results
        pred <- filter(pred, !is.na(mle))
        #If all predictions are NA, use unknown words prediction
        if(all(is.na(pred$mle))){
            
        }
    }
    
    pred
}