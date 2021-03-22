
### Question 1
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

outcome[, 11] <- as.numeric(outcome[, 11])

hist(outcome[, 11])



### Question 2
best <- function(state, outcome) {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Check that state and outcome are valid
    if (!is.element(state, data$State)) {stop("invalide state")}
    
    switch(outcome, 'heart attack'= {col_used=11}, 
                    'heart failure'= {col_used=17},
                    'pneumonia'= {col_used=23},
           stop('invalid outcome'))
    

    ## Return hospital name in that state with lowest 30-day death rate
    col_used_name <- colnames(data)[col_used]
    tmp <- data[data$State==state, c("Hospital.Name", col_used_name)]
    tmp[,col_used_name] <- as.numeric(tmp[, col_used_name])

    names <- tmp[which(tmp[col_used_name] == min(tmp[col_used_name], na.rm = T)),]$Hospital.Name
    names[order(names)][1]
}



### Question 3
rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if (!is.element(state, data$State)) {stop("invalide state")}
    
    switch(outcome, 'heart attack'= {col_used=11}, 
                    'heart failure'= {col_used=17},
                    'pneumonia'= {col_used=23},
           stop('invalid outcome'))
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    col_used_name <- colnames(data)[col_used]
    tmp <- data[data$State==state, c("Hospital.Name", col_used_name)]
    tmp[,col_used_name] <- as.numeric(tmp[, col_used_name])

    names <- tmp[order(tmp[col_used_name], tmp["Hospital.Name"], na.last=NA),]$Hospital.Name
    nb_names <- length(names)

    if (is.numeric(num)) { names[num] }
    else if (num == 'best') { names[1] }
    else {names[nb_names] }
    
}



### Question 4
rankall <- function(outcome, num = "best") {
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    switch(outcome, 'heart attack'= {col_used=11}, 
                    'heart failure'= {col_used=17},
                    'pneumonia'= {col_used=23},
           stop('invalid outcome'))
    
    ## For each state, find the hospital of the given rank
    col_used_name <- colnames(data)[col_used]
    tmp <- data[, c("State", "Hospital.Name", col_used_name)]
    tmp[,col_used_name] <- as.numeric(tmp[, col_used_name])
    
    all_states <- unique(tmp$State)[order(unique(tmp$State))]
    
    searched_hospitals <- sapply(all_states, function (state) {
        
        used_data <- tmp[tmp$State == state,]
        ordered_used_data <-used_data[order(used_data[,col_used_name], 
                                            used_data[,"Hospital.Name"], 
                                            na.last = NA),]  
        if (num == "best"){num <- 1}
        else if(num == "worst") {num <- nrow(ordered_used_data)}
        
        ordered_used_data[num, "Hospital.Name"]
        
    })
   
    result <- data.frame("hospital"=searched_hospitals, "state"= all_states)
    result
}