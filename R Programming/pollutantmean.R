pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  pollutData <- loadfiles(directory,id)
  
  colmeans <- 1
  for (i in 1:length(id)){
    col <- pollutData[[i]][[pollutant]]
    colmeans <- c(colmeans,col[!is.na(col)]) 
    }
  
  mean(colmeans[2:length(colmeans)])
}

loadfiles <- function(mypath,id)  {
  filenames=list.files(path=mypath, full.names=TRUE)
  filenames <- filenames[id]
  datalist = lapply(filenames, function(x){read.csv(file=x,header=T)})
  return(datalist)
}