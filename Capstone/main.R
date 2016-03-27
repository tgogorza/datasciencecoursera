setwd("D:/Cursos/Data Science/datasciencecoursera/Capstone")
source("loadData.R")
source("cleanData.R")
source("exploratoryAnalysis.R")

#Read the text files and paste them together
#Read Blogs file
blogs <- readFile('Data/en_US.blogs.txt')
blogs2 <- readFile2('Data/en_US.blogs.txt')$V1
#Read News file
news <- readFile('Data/en_US.news.txt')
news2 <- readFile2('Data/en_US.news.txt')$V1
#Read Tweets file
tweets <- readFile('Data/en_US.twitter.txt')
tweets2 <- readFile2('Data/en_US.twitter.txt')
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
bigram_table <- sort(table(bigrams), decreasing = TRUE)
trigram_table <- sort(table(trigrams), decreasing = TRUE)


blogtxt <- textfile('Data/en_US.blogs.txt')
blogcorpus <- corpus(blogtxt)
blogcorpus <- sample(blogcorpus,45000)
newstxt <- textfile('Data/en_US.news.txt')
newscorpus <- corpus(newstxt)
newscorpus <- sample(newscorpus,50000)
twittertxt <- textfile('Data/en_US.twitter.txt')
twittercorpus <- corpus(twittertxt)
twittercorpus <- sample(twittercorpus,110000)
corpus <- blogcorpus + newscorpus + twittercorpus

newstokens <- tokenize(newscorpus, what = "word", removeNumbers = TRUE, removePunct = TRUE, 
                       removeSeparators = TRUE, removeTwitter = TRUE, removeHyphens = FALSE,
                       ngrams = 1)[[1]]
  
  
mydfm <- dfm(corpus,toLower=TRUE,removeTwitter = TRUE,removeSeparators = TRUE,removePunct = TRUE,removeNumbers = TRUE)
topfeatures(mydfm,30)
freqs <- tf(mydfm,scheme="log")


blogdfm <- dfm(blogcorpus,toLower=TRUE,removeTwitter = TRUE,removeSeparators = TRUE,removePunct = TRUE,removeNumbers = TRUE)
require(RColorBrewer)
plot(blogdfm, max.words = 100, colors = brewer.pal(6, "Dark2"), scale = c(8, .5))
