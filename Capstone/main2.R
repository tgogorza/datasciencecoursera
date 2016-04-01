#setwd("D:/Cursos/Data Science/datasciencecoursera/Capstone")
source("loadData.R")
source("createModel.R")
require(tidyr)
require(stringr)
require(quanteda)

#Load the data from txt files
blogs <- fread('Data/en_US.blogs.txt', sep = "\n",header = FALSE, encoding = "UTF-8",
               verbose = FALSE, showProgress = FALSE)$V1
news <- fread('Data/en_US.news.txt', sep = "\n",header = FALSE, encoding = "UTF-8", 
              verbose = FALSE, showProgress = FALSE)$V1
tweets <- readFile('Data/en_US.twitter.txt')

#Take random samples representing 30% of each dataset 
sample <- rbinom(length(blogs),1,0.3)
blogs <- blogs[sample == 1]
sample <- rbinom(length(news),1,0.3)
news <- news[sample == 1]
sample <- rbinom(length(tweets),1,0.3)
tweets <- tweets[sample == 1]
alltext = toLower(c(blogs,news,tweets))

#alltextcorpus <- corpus(alltext)
tokens <- tokenize(alltext,what = "word", removeNumbers = TRUE, removePunct = TRUE,
                    removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE)
#Remove stop-words
tokens <- removeFeatures(tokens,stopwords("english"))
tokens <- do.call(c, tokens)

remove("alltext","tweets","news","blogs","sample")

# bigrams <- ngrams(tokens,2)
# trigrams <- ngrams(tokens,3)
# fourgrams <- ngrams(tokens,4)


token_table <- sort(table(tokens), decreasing = TRUE)
# remove("tokens")
# bigram_table <- sort(table(bigrams), decreasing = TRUE)
# remove("bigrams")
# trigram_table <- sort(table(trigrams), decreasing = TRUE)
# remove("trigrams")
# fourgram_table <- sort(table(fourgrams), decreasing = TRUE)
# remove("fourgrams")


#Create data frame with tokens frequencies and word length
token_table <- sort(table(tokens), decreasing = TRUE)
tokenDF <- data.frame(token = names(token_table), count = as.vector(token_table))
tokenDF$token <- as.vector(tokenDF$token)
#tokenDF <- mutate(tokenDF, freq = round((count/totaltokens)*100,4), length = nchar(token))
#quantile(tokenDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
save(tokenDF,file="tokenDF.RData")
remove("token_table")

bigramDF <- data.frame(gram = names(bigram_table), count = as.vector(bigram_table))
bigramDF$gram <- as.vector(bigramDF$gram)
#Remove some weird bigrams
bigramDF <- filter(bigramDF, str_count(gram,"_") == 1 )
bigramDF <- separate(bigramDF,gram,c("word1","word2"),"_",remove = FALSE)
#bigramDF <- mutate(bigramDF, freq = round((count/totalbigrams)*100,4) )
#If we remove bigrams with just 1 occurrence (which are not really helpful), we can reduce the size of the DF about 75%
#quantile(bigramDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
bigramDF <- filter(bigramDF,count > 1)
save(bigramDF,file="bigramDF.RData")
remove("bigram_table")

trigramDF <- data.frame(gram = names(trigram_table), count = as.vector(trigram_table))
trigramDF$gram <- as.vector(trigramDF$gram)
#Remove some weird trigrams
trigramDF <- filter(trigramDF, str_count(gram,"_") == 2 )
trigramDF <- separate(trigramDF,gram,c("word1","word2","word3"),"_",remove = FALSE)
#trigramDF <- mutate(trigramDF, freq = round((count/totaltrigrams)*100,4))
#If we remove trigrams with just 1 occurrence (which are not really helpful), we can reduce the size of the DF about 90%
#quantile(trigramDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
trigramDF <- filter(trigramDF,count > 1)
save(trigramDF,file="trigramDF.RData")
remove("trigram_table")

fourgramDF <- data.frame(gram = names(fourgram_table), count = as.vector(fourgram_table))
fourgramDF$gram <- as.vector(fourgramDF$gram)
#Remove some weird trigrams
fourgramDF <- filter(fourgramDF, str_count(gram,"_") == 3 )
fourgramDF <- separate(fourgramDF,gram,c("word1","word2","word3","word4"),"_",remove = FALSE)
#fourgramDF <- mutate(fourgramDF, freq = round((count/totalfourgrams)*100,4))
#If we remove trigrams with just 1 occurrence (which are not really helpful), we can reduce the size of the DF about 90%
#quantile(fourgramDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
fourgramDF <- filter(fourgramDF,count > 1)
save(fourgramDF,file="fourgramDF.RData")
remove("fourgram_table")

#---------------------


#Create data frame with tokens frequencies and word length
token_table <- sort(table(tokens), decreasing = TRUE)
tokenDF <- data.frame(token = names(token_table), count = as.vector(token_table))
tokenDF$token <- as.vector(tokenDF$token)
#tokenDF <- mutate(tokenDF, freq = round((count/totaltokens)*100,4), length = nchar(token))
#quantile(tokenDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
save(tokenDF,file="tokenDF.RData")
remove("token_table")

bigrams <- createModel(tokens,2)
save(bigrams,file="bigramDF.RData")
remove("bigrams")

trigrams <- createModel(tokens,3)
save(trigrams,file="trigramDF.RData")
remove("trigrams")

fourgrams <- createModel(tokens,4)
save(fourgrams,file="fourgramDF.RData")
remove("fourgrams")

