corr <- function(directory, threshold=0){
    
    RES <- numeric(0)
    
    for (f in list.files(directory)){
        
        tmp <-  read.csv(paste(directory, f, sep="/"), header=TRUE)
        if (sum(complete.cases(tmp)) >  threshold){
            val <- cor(tmp$sulfate, tmp$nitrate, use = "na.or.complete")
            RES <- c(RES, val)
        }
    }
    RES
}
