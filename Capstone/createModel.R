require(dplyr)
require(tidyr)
require(stringr)
require(quanteda)
require(edgeR)

##
##  Gets MLE and Good-Turing probabilities
##  @param ngram Current 
##
getEstimators <- function(ngram,model){
    #ESTA FUNCION TIENE QUE SACAR ASIGNAR LA MLE PARA CADA NGRAM    
    
    #lastunderscore <- tail(stri_locate_all(pattern = '_', ngram, fixed = TRUE)[[1]][,1],1)
    #phrase <- substr(ngram,1,lastunderscore)
    #phrase <- preprocess(ngram,grams-2,underscoreend = TRUE)
    
    phrase <- extractLastWord(ngram["gram"])[1]
    regex <- paste('^', phrase, "_", sep = "")
    phrases <- filter(model, grepl(regex, gram))
    
    #regex <- paste(phrase, "_", sep = "")
    #phrases <- filter(model, substr(gram,1,str_length(regex)) == regex)
    
    total <- sum(phrases$count)
    count <- as.integer(ngram["count"])
    mle <- count / total
    
    goodT <- goodTuring(phrases$count)
    ind <- which(goodT$count==count)
    gt <- goodT$proportion[ind]
    
#     #Create vector of Nc (counts of elements with c repetitions) 
#     ncs <- table(phrases$count)
#     #Good-Turing discounting
#     #Things that have never occured
#     if(ngram["count"] == 0){
#         gt <- as.integer(ncs[1]) / total
#     }else if(ngram["count"] == max(phrases$count)){
#         gt <- count/total
#     }else{
#         c <- as.character(ngram["count"])
#         cind <- which(names(ncs)==c)
#         
#         cplusone <- names(ncs)[cind+1]
#         count <-  as.integer(cplusone) * ncs[cplusone] / ncs[c] 
#         gt <- count/total    
#     }
        
    c(mle,as.numeric(gt))
}

extractLastWord <- function(ngram){
    words <- str_split(ngram,"_")[[1]]
    last <- tail(words,1)
    phrase <- paste(words[1:length(words)-1],collapse = "_")
    c(phrase,last)
}

createModel <- function(tokens, grams){
    
    #Get word counts
    words <- sort(table(tokens), decreasing = TRUE)
    #Replace random low freq word for <UNK> to account for unknown words
    rareword <- names(sample(words[words==2],1))
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
    #ngramDF <- separate(ngramDF,gram,paste("word",1:grams,sep=""),"_",remove = FALSE)
    
    estimators <- apply(ngramDF, 1, FUN = function(x) getEstimators(x,ngramDF))
    estimators <- data.frame(matrix(unlist(estimators), nrow=dim(ngramDF)[1], byrow=TRUE))
    #ngramDF <- mutate(ngramDF, estimators = getEstimators())
    ngramDF$mle <- estimators[,1]
    ngramDF$gt <- estimators[,2]
    
    #bigramDF <- mutate(bigramDF, freq = round((count/totalbigrams)*100,4) )
    #If we remove bigrams with just 1 occurrence (which are not really helpful), we can reduce the size of the DF about 75%
    #quantile(bigramDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
    
    #ngramDF <- filter(ngramDF,count > 10)
    ngramDF
    
}

smoothingGT <- function(x){
    
} 