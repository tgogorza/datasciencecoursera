require(dplyr)
require(tidyr)
require(stringr)
require(quanteda)
require(edgeR)

#' Gets MLE and Good-Turing probabilities
#' @param ngram phrase to calculate likelyhood for
#' @param model language model
#' @return a matrix with estimators values
getEstimators <- function(ngram,model){

    phrase <- extractLastWord(ngram["gram"])[1]
    regex <- paste('^', phrase, "_", sep = "")
    phrases <- filter(model, grepl(regex, gram))
    
    total <- sum(phrases$count)
    count <- as.integer(ngram["count"])
    mle <- count / total
    
    goodT <- goodTuring(phrases$count)
    ind <- which(goodT$count==count)
    gt <- goodT$proportion[ind]
        
    c(mle,as.numeric(gt))
}

#' Extracts last word from a string
#' @param ngram string
#' @return phrase and last word split
extractLastWord <- function(ngram){
    words <- str_split(ngram,"_")[[1]]
    last <- tail(words,1)
    phrase <- paste(words[1:length(words)-1],collapse = "_")
    c(phrase,last)
}

#' Creates a language model given a set of tokens and a number
#' @param tokens list of tokens
#' @param grams integer specifies the language model N-Gram type (i.e. 2 for 2-Gram, 3 for 3-Gram,etc.)
#' @return language model data frame
createModel <- function(tokens, grams){
    
    #Get word counts
    words <- sort(table(tokens), decreasing = TRUE)
    #Replace random low freq word for <UNK> to account for unknown words
    #rareword <- names(sample(words[words==2],1))
    #TODO: Some more work to be done here...
    
    ngramsvector <- ngrams(tokens,grams)
    ngram_table <- sort(table(ngramsvector), decreasing = TRUE)
    ngram_table <- ngram_table[ngram_table > 5]
   
    remove("ngramsvector")
    ngramDF <- data.frame(gram = names(ngram_table), count = as.vector(ngram_table))
    remove("ngram_table")
    ngramDF$gram <- as.vector(ngramDF$gram)
    #Remove some weird formatted ngrams (i.e. leave only trigrams with format word1_word2_word3)
    ngramDF <- filter(ngramDF, str_count(gram,"_") == grams - 1 )
    
    estimators <- apply(ngramDF, 1, FUN = function(x) getEstimators(x,ngramDF))
    estimators <- data.frame(matrix(unlist(estimators), nrow=dim(ngramDF)[1], byrow=TRUE))
    ngramDF$mle <- estimators[,1]
    ngramDF$gt <- estimators[,2]
    
    ngramDF
    
}