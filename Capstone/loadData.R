library(LaF)
library(dplyr)
library(data.table)

#textDataFrame <- function(textvector)   data.frame(text = textvector, charcount = sapply(textvector, function(l)  nchar(l), USE.NAMES = FALSE ))

#   Reads a text file line by line and returns a vector of text lines
#   filename -> path to the text file
#   returns -> vector of text lines
readFile <- function(filename){
    conn <- file(filename,'r')
    texts <- readLines(conn, warn = FALSE, skipNul = TRUE, encoding="UTF-8")
    close(conn)
    texts
}

readFile2 <- function(filename){
    texts <- fread(filename,sep = "\n",header = FALSE, encoding = "UTF-8")
    texts
}