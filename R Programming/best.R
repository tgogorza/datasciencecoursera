best <- function(state, outcome){
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
  names(filtered_data) <- c("Name","Outcome")
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  return (min(filtered_data[as.numeric(filtered_data$Outcome) == min(as.numeric(filtered_data$Outcome)),1]))
  
}