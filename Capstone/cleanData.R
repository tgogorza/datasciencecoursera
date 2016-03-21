library(tm)
library(quanteda)

#tokenizer <- function(x) unlist(strsplit(as.character(x), "[[:space:],\\.!?()=+_&{}:;\"]+")) #faltan agregar cosas (", smilies, hashtags, etc)
#tokenizer <- function(x) unlist(strsplit(as.character(x), "[[:space:]]+"))


#Given a corpus, this function removes punctuation, numbers and (oprionally) bad words and
#returnr a list of tokens
tokenize <- function(corpus, remove_symbols = TRUE, filter_bad_words = FALSE, convert_to_lower = FALSE)
{
    if(remove_symbols){
        corpus <- removeSymbols(corpus)    
    }
    
    #Filter bad words
    if(filter_bad_words){
        corpus <- profanityFilter(corpus)
    }
    
    #Tokenize lines
    tokens <- sapply(corpus, FUN = function(x) unlist(strsplit(as.character(x), "[[:space:]]+")), USE.NAMES = FALSE)
    #tokens <- sapply(cleancorpus, FUN = function(x) ngram(as.character(x),1), USE.NAMES = FALSE)
    #Flatten lists to 1 list of tokens
    tokens <- do.call(c, tokens)
    #Remove empty tokens
    tokens <- tokens[tokens != ""]
    
    #Convert UPPER to lower case
    if(convert_to_lower)
        tokens <- tolower(tokens)
    
    tokens
}

#Remove numbers and punctuation
removeSymbols <- function(corpus)
{
    cleancorpus <- sapply(corpus, FUN = function(x) gsub("[^[:alnum:] | ']", "", x), USE.NAMES = FALSE)
    
    #cleancorpus <- removeNumbers(removePunctuation(corpus,preserve_intra_word_dashes = FALSE))
    
    #cleancorpus <- sapply(cleancorpus, FUN = function(x) gsub(",.!?()=+\\-_&\\-\\{\\}:;`''~\\\"]+", "",x), USE.NAMES = FALSE)
    
    #cleancorpus <- sapply(cleancorpus, FUN = function(x) gsub("[[:punct:]]", "",x), USE.NAMES = FALSE)
    cleancorpus <- cleancorpus[cleancorpus != ""]
    cleancorpus
}

#Loads a text file and returns a list of tokens
tokenizeFile <- function(file)
{
    #Load lines into a list
    lines <- readFile(file)
    #Tokenize lines
    tokenize(lines)
}

#Removes bad words
profanityFilter <- function(corpus)
{
    badwords <- readFile("Data/en_profanity.txt")
    cleancorpus <- removeWords(corpus,badwords)
    cleancorpus
}