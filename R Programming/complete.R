complete <- function(directory, id = 1:332) {

  filenames=list.files(path=directory, full.names=TRUE)
  filenames <- filenames[id]
  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})

  
  frame <- data.frame(id,sapply(datalist,function(x){dim(x[complete.cases(x),])[1]}))
  colnames(frame) <- c("id","nobs")
  frame
}