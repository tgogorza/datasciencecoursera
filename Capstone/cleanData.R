library(tm)

#' Given a corpus, this function removes punctuation, numbers and bad words and converts the strings to lower case
#' @param corpus a text corpus
#' @param remove_symbols logical
#' @param filter_bad_words
#' @param convert_to_lower
#' @return a list of tokens
tokenizer <- function(corpus, remove_symbols = TRUE, filter_bad_words = FALSE, convert_to_lower = FALSE)
{
    if(remove_symbols){ corpus <- removeSymbols(corpus) }
    #Filter bad words
    if(filter_bad_words){ corpus <- profanityFilter(corpus) }
    #Tokenize lines
    tokens <- sapply(corpus, FUN = function(x) unlist(strsplit(as.character(x), "[[:space:]]+")), USE.NAMES = FALSE)
    #Flatten lists to 1 list of tokens
    tokens <- do.call(c, tokens)
    #Remove empty tokens
    tokens <- tokens[tokens != ""]
    #Convert UPPER to lower case
    if(convert_to_lower)
        tokens <- tolower(tokens)
    
    tokens
}

#' Remove numbers and punctuation
#' @param a text corpus
#' @return corpus without symbols
removeSymbols <- function(corpus)
{
    cleancorpus <- sapply(corpus, FUN = function(x) gsub("[^[:alnum:] | ']", "", x), USE.NAMES = FALSE)
    cleancorpus <- cleancorpus[cleancorpus != ""]
    cleancorpus
}

#' Loads a text file and returns a list of tokens
#' @param  a text file to tokenize
#' @return tokens extracted from text file
tokenizeFile <- function(file)
{
    #Load lines into a list
    lines <- readFile(file)
    #Tokenize lines
    tokenize(lines)
}

#' Removes bad words
#' @param a text corpus
#' @return corpus without profanity words
profanityFilter <- function(corpus)
{
    badwords <- readFile("Data/en_profanity.txt")
    cleancorpus <- removeWords(corpus,badwords)
    cleancorpus
}