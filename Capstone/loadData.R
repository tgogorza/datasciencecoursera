library(dplyr)
library(data.table)

#' Reads a text file line by line and returns a vector of text lines
#' @param filename path to the text file
#' @return vector of text lines
readFile <- function(filename){
    conn <- file(filename,'r')
    texts <- readLines(conn, warn = FALSE, skipNul = TRUE, encoding="UTF-8")
    close(conn)
    texts
}

#' Reads a text file line by line and returns a vector of text lines (faster than "readFile" but not always works)
#' @param filename path to the text file
#' @return vector of text lines
readFile2 <- function(filename){
    texts <- fread(filename,sep = "\n",header = FALSE, encoding = "UTF-8")
    texts
}