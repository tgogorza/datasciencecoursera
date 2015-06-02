rankall <- function(outcome,rank = "best"){
  ## Read outcome data
  data <- read.csv("hospital/outcome-of-care-measures.csv", colClasses = "character")
  
  ## List possible outcome values
  valid_outcomes <- c(11,17,23) #data.frame("heart attack"=11,"heart failure"=17,"pneumonia"=23)
  names(valid_outcomes) <- c("heart attack","heart failure","pneumonia")
  ## List available states
  valid_states <- unique(data["State"])
  
  ## Check that state and outcome are valid
  if(!(outcome %in% names(valid_outcomes)))
    stop("invalid outcome")
  if(!(state %in% valid_states$State))
    stop("invalid state")
  
  ##Get data filtered by outcome
  filtered_data <- data[,c(2,valid_outcomes[outcome],7)]
  ##Remove NAs
  ##filtered_data <- filtered_data[filtered_data[2] != "Not Available",]
  names(filtered_data) <- c("Name","Rate","State")
  ##Split into a list of data by state
  data_by_state <- split(filtered_data,filtered_data$State)
  
  res <- lapply(data_by_state, function(x) rankstate(x,outcome,rank))
  res <- data.frame(cbind(res,names(res)))
  names(res) <- c("hospital","state")
  return(res)
}

rankstate <- function(statedata,outcome,rank){
  statedata <- statedata[with(statedata, order(Rate, Name)), ]
  ##Create rankings
  ranked_data <- rank(as.numeric(statedata$Rate),ties.method = "first")
  ##Join ranked data to data frame
  statedata <- data.frame(statedata,ranked_data)
  names(statedata) <- c("Name","Rate","State","Rank")
  
  ##Handle "best" and "worst" ranks
  if(rank == "best") rank <- 1
  if(rank == "worst") rank <- nrow(statedata)
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  ##If rank number is valid
  if(rank >= 1 && rank <= nrow(statedata))
    return(statedata[as.numeric(statedata$Rank) == rank,1])
  else
    return(NA)
}