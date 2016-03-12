setwd("D:/Cursos/Data Science/datasciencecoursera/Capstone")
source("loadData.R")
source("cleanData.R")

#Read the text files and paste them together
#Read Blogs file
blogs <- readFile('Data/en_US.blogs.txt')
#Read News file
news <- readFile('Data/en_US.news.txt')
#Read Tweets file
tweets <- readFile('Data/en_US.twitter.txt')
#alltext <- c(blogs,news,tweets)
#Sample files (30%)
sample <- rbinom(length(blogs),1,0.1)
blogs <- blogs[sample == 1]
sample <- rbinom(length(news),1,0.1)
news <- news[sample == 1]
sample <- rbinom(length(tweets),1,0.1)
tweets <- tweets[sample == 1]
alltext <- c(blogs,news,tweets)
sample <- rbinom(length(alltext),1,0.1)
alltext <- alltext[sample == 1]

# source_text <- VectorSource(alltext)
# corpus <- Corpus(source_text)
# corpus <- tm_map(corpus, removePunctuation)
# corpus <- tm_map(corpus, stripWhitespace)
# corpus <- tm_map(corpus, removeWords, readFile("Data/en_profanity.txt"))
# dtm <- DocumentTermMatrix(corpus)
# #dtm2 <- as.matrix(dtm)
# frequency <- colSums(dtm2)
# frequency <- sort(frequency, decreasing=TRUE)
# head(frequency)

#Clean and Tokenize corpus
tokens <- tokenize(alltext)
tokensnbw <- tokenize(alltext,filter_bad_words = TRUE)

#Create ordered table of word frequencies
token_table <- sort(table(tokens), decreasing = TRUE)
