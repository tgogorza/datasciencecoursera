library(tm)

#tokenizer <- function(x) unlist(strsplit(as.character(x), "[[:space:],\\.!?()=+_&{}:;\"]+")) #faltan agregar cosas (", smilies, hashtags, etc)
#tokenizer <- function(x) unlist(strsplit(as.character(x), "[[:space:]]+"))


#Given a corpus, this function removes punctuation, numbers and (oprionally) bad words and
#returnr a list of tokens
tokenize <- function(corpus, filter_bad_words = FALSE, convert_to_lower = FALSE)
{
    #Remove numbers and punctuation
    cleancorpus <- removeNumbers(removePunctuation(corpus,preserve_intra_word_dashes = FALSE))
    cleancorpus <- sapply(cleancorpus, FUN = function(x) gsub(",.!?()=+\\-_&\\-\\{\\}:;`'''~\"\\\"]+", "",x))
    #cleancorpus <- sapply(cleancorpus, FUN = function(x) gsub("[^[:alnum:]]", " ",x))
    
    #Filter bad words
    if(filter_bad_words){
        cleancorpus <- profanityFilter(cleancorpus)
    }
    
    #Tokenize lines
    tokens <- sapply(cleancorpus, FUN = function(x) unlist(strsplit(as.character(x), "[[:space:]]+")), USE.NAMES = FALSE)
    #Flatten lists to 1 list of tokens
    tokens <- do.call(c, tokens)
    
    #Convert UPPER to lower case
    if(convert_to_lower)
        tokens <- tolower(tokens)
    
    tokens
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

##Tokenize inputs
#tkblogs <- sapply(blogssample, FUN = tokenizer, USE.NAMES = FALSE)
#tknews <- sapply(newssample, FUN = tokenizer, USE.NAMES = FALSE)
#tktweets <- sapply(tweetssample, FUN = tokenizer, USE.NAMES = FALSE)




