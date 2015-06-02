corr <- function(directory, threshold = 0) {
  #Load files
  filenames=list.files(path=directory, full.names=TRUE)

  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
  
  completes <- lapply(datalist,function(x){x[complete.cases(x),]})
  
  meetsthres <- sapply(completes,function(x){length(x[[1]])>=threshold})
  thres <- completes[meetsthres]
  corrlist <- sapply(thres,function(x){cor(x[2],x[3])})
}
