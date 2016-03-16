library(LaF)
library(dplyr)

textDataFrame <- function(textvector)   data.frame(text = textvector, charcount = sapply(textvector, function(l)  nchar(l), USE.NAMES = FALSE ))

#   Reads a text file line by line and returns a vector of text lines
#   filename -> path to the text file
#   returns -> vector of text lines
readFile <- function(filename){
    conn <- file(filename,'r')
    texts <- readLines(conn, warn = FALSE, skipNul = TRUE, encoding="UTF-8")
    close(conn)
    texts
}

# #Sample files
# lenBlogs <- 899288
# lenNews <- 77259
# lenTweets <- 2360148
# blogs <- readSample('Data/en_US.blogs.txt',0.3,lenBlogs)
# news <- readSample('Data/en_US.news.txt',0.3,lenNews)
# tweets <- readSample('Data/en_US.twitter.txt',0.3,lenTweets)



# #Create Data Frames with (Text, Character count, Source)
# blogsDF <- textDataFrame(blogssample)
# newsDF <- textDataFrame(newssample)
# tweetsDF <- textDataFrame(tweetssample)
