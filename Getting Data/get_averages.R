#Get averages groupes by subject and activity
getaverages <- function(data){
  groupeddata <- group_by(data,activity,subject)
  averages <- summarise_each(groupeddata,funs(mean))
  
  #Save data to txt file
  write.table(averages,"grouped_averages.txt",row.names=FALSE)
  return(averages)
}