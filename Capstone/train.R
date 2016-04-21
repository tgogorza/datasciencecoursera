#setwd("D:/Cursos/Data Science/datasciencecoursera/Capstone")
source("loadData.R")
source("createModel.R")
source("prediction.R")
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
sample <- rbinom(length(blogs),1,0.1)
blogs <- blogs[sample == 1]
sample <- rbinom(length(news),1,0.1)
news <- news[sample == 1]
sample <- rbinom(length(tweets),1,0.1)
tweets <- tweets[sample == 1]
alltext = toLower(c(blogs,news,tweets))

tokens <- tokenize(alltext, what = "word", removeNumbers = TRUE, removePunct = TRUE,
                    removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE)
#Remove stop-words
#tokens <- removeFeatures(tokens,stopwords("english"))
tokens <- do.call(c, tokens)
save(tokens,file="tokens.RData")

remove("alltext","tweets","news","blogs","sample")

#Create data frame with tokens frequencies and word length
token_table <- sort(table(tokens), decreasing = TRUE)
tokenDF <- data.frame(token = names(token_table), count = as.vector(token_table))
tokenDF$token <- as.vector(tokenDF$token)
#tokenDF <- mutate(tokenDF, freq = round((count/totaltokens)*100,4), length = nchar(token))
#quantile(tokenDF$count, probs = c(.1,.2,.5,.75,.8,.9,.95,.99))
save(tokenDF,file="tokenDF.RData")
remove("token_table")

Rprof("trainProfBigram.out")
bigrams <- createModel(tokens,2)
save(bigrams,file="bigramDF.RData")
#remove("bigrams")
Rprof(NULL)
summaryRprof("trainProfBigram.out")

Rprof("trainProf.out")
trigrams <- createModel(tokens,3)
save(trigrams,file="trigramDF.RData")
#remove("trigrams")
Rprof(NULL)
summaryRprof("trainProf.out")

Rprof("trainProfFour.out")
fourgrams <- createModel(tokens,4)
save(fourgrams,file="fourgramDF.RData")
#remove("fourgrams")
Rprof(NULL)
summaryRprof("trainProfFour.out")

