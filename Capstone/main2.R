#setwd("D:/Cursos/Data Science/datasciencecoursera/Capstone")
source("loadData.R")
#library(tm)
library(quanteda)

# blogtxt <- textfile('Data/en_US.blogs.txt')
# blogcorpus <- corpus(blogtxt,sep="\n")
# #samplesize <- length(texts(blogcorpus)) * 0.25
# newstxt <- textfile('Data/en_US.news.txt')
# newscorpus <- corpus(newstxt)
# #newscorpus <- sample(toLower(newscorpus),50000)
# twittertxt <- textfile('Data/en_US.twitter.txt')
# twittercorpus <- corpus(twittertxt)
# #twittercorpus <- sample(twittercorpus,110000)
# corpus <- blogcorpus + newscorpus + twittercorpus
# 
# newstokens <- tokenize(newscorpus, what = "word", removeNumbers = TRUE, removePunct = TRUE, 
#                        removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE,
#                        ngrams = 1)[[1]]


#Load the data from txt files
blogs <- fread('Data/en_US.blogs.txt', sep = "\n",header = FALSE, encoding = "UTF-8",
               verbose = FALSE, showProgress = FALSE)$V1
news <- fread('Data/en_US.news.txt', sep = "\n",header = FALSE, encoding = "UTF-8", 
              verbose = FALSE, showProgress = FALSE)$V1
tweets <- readFile('Data/en_US.twitter.txt')

#Take random samples representing 30% of each dataset 
sample <- rbinom(length(blogs),1,0.1)
blogs <- blogs[sample == 1]
sample <- rbinom(length(news),1,0.1)
news <- news[sample == 1]
sample <- rbinom(length(tweets),1,0.1)
tweets <- tweets[sample == 1]
alltext = toLower(c(blogs,news,tweets))

alltextcorpus <- corpus(alltext)
tokens <- tokenize(alltext,what = "word", removeNumbers = TRUE, removePunct = TRUE, 
                    removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE,
                    ngrams = 1)
tokens <- do.call(c, tokens)
bigrams <- tokenize(alltext,what = "word", removeNumbers = TRUE, removePunct = TRUE, 
                    removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE,
                    ngrams = 2)
bigrams <- do.call(c, bigrams)
trigrams <- tokenize(alltext,what = "word", removeNumbers = TRUE, removePunct = TRUE, 
                     removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE,
                     ngrams = 3)
trigrams <- do.call(c, trigrams)

token_table <- sort(table(tokens), decreasing = TRUE)
bigram_table <- sort(table(bigrams), decreasing = TRUE)
trigram_table <- sort(table(trigrams), decreasing = TRUE)

#Create data frame with tokens frequencies and word length
tokenDF <- data.frame(token = names(token_table), count = as.vector(token_table))
tokenDF$token <- as.vector(tokenDF$token)
tokenDF <- mutate(tokenDF, freq = round((count/totaltokens)*100,2), length = nchar(token))

bigramDF <- data.frame(gram = names(bigram_table), count = as.vector(bigram_table))
bigramDF$gram <- as.vector(bigramDF$gram)
bigramDF <- separate(bigramDF,gram,c("word1","word2"),"_",remove = FALSE)
bigramDF <- mutate(bigramDF, freq = round((count/totalbigrams)*100,2) )

trigramDF <- data.frame(gram = names(trigram_table), count = as.vector(trigram_table))
trigramDF$gram <- as.vector(trigramDF$gram)
trigramDF <- separate(trigramDF,gram,c("word1","word2","word3"),"_",remove = FALSE)
trigramDF <- mutate(trigramDF, freq = round((count/totaltrigrams)*100,2))