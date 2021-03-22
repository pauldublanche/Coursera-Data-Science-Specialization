complete <- function(directory, id=1:332){
    
    RES <- data.frame( "id"=id, "nobs"=numeric(length(id)))
    
    for (i in id){
        tmp <- read.csv(file.path(directory, paste(sprintf("%03d", i), ".csv", sep="")))
        
        RES[RES["id"] == i,]["nobs"] <- sum(complete.cases(tmp))
    }
    RES
}
