cleanfeaturenames <- function(names){
  lapply(names,function(name){
    name <- gsub('^[^a-zA-Z0-9]+', '', name)
    name <- gsub('[^a-zA-Z0-9]+$', '', name)
    #name <- gsub('_+', '', name)
    #name <- gsub('-+', '', name)
    #name <- gsub('\\s+', '', name)
    #name <- gsub('\\.+', '', name)
    #name <- gsub('[\\\\/]+', '', name)
    name <- gsub("[[:punct:]]", '', name)
    return(tolower(name))  
  })
}