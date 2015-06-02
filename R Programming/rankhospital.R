rankhospital <- function(state,outcome,rank = "best"){
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
  
  ##Get data filtered by state and outcome
  filtered_data <- data[data$State == state,c(2,valid_outcomes[outcome])]
  ##Remove NAs
  filtered_data <- filtered_data[filtered_data[2] != "Not Available",]
  names(filtered_data) <- c("Name","Rate")
  filtered_data <- filtered_data[with(filtered_data, order(Rate, Name)), ]
  ##Create rankings
  ranked_data <- rank(as.numeric(filtered_data$Rate),ties.method = "first")
  ##Join ranked data to data frame
  filtered_data <- data.frame(filtered_data,ranked_data)
  names(filtered_data) <- c("Name","Rate","Rank")
    
  ##Handle "best" and "worst" ranks
  if(rank == "best") rank <- 1
  if(rank == "worst") rank <- nrow(filtered_data)
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  ##If rank number is valid
  if(rank >= 1 && rank <= nrow(filtered_data))
    return(filtered_data[as.numeric(filtered_data$Rank) == rank,1])
  else
    return(NA)
}