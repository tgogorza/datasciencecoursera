require(dplyr)
require(tidyr)
require(stringr)

createModel <- function(tokens, grams){
    
    ngramsvector <- ngrams(tokens,grams)
    ngram_table <- sort(table(ngramsvector), decreasing = TRUE)
    #ngram_table2 <- rle(sort(ngramsvector))
    remove("ngramsvector")
    ngramDF <- data.frame(gram = names(ngram_table), count = as.vector(ngram_table))
    remove("ngram_table")
    ngramDF$gram <- as.vector(ngramDF$gram)
    #Remove some weird formatted ngrams (i.e. leave only trigrams with format word1_word2_word3)
    ngramDF <- filter(ngramDF, str_count(gram,"_") == grams - 1 )
    ngramDF <- separate(ngramDF,gram,paste("word",1:grams,sep=""),"_",remove = FALSE)
    #bigramDF <- mutate(bigramDF, freq = round((count/totalbigrams)*100,4) )
    #If we remove bigrams with just 1 occurrence (which are not really helpful), we can reduce the size of the DF about 75%
    #quantile(bigramDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
    ngramDF <- filter(ngramDF,count > 1)
    ngramDF
    
}