pollutantmean <- function(directory, pollutant, id=1:332){
    
    name <- function(i){
        if (i<10) {paste("00",i,".csv", sep="")}
        else if (i<100) {paste("0",i,".csv", sep="")}
        else  {paste(i,".csv", sep="")}
    }
    
    data <- c()
    for (i in id){
        f <-read.csv(paste(directory,name(i), sep="/"), header = TRUE)
        tmp <- f[pollutant][!is.na(f[pollutant])]
        data <- c(data, tmp)
    }
    
    mean(data)  
}
