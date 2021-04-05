### Question 1
library(httr)

oauth_endpoints("github")
myapp <- oauth_app("github",
                   key = "02c980178d7ef43a4543", # "My Cliend ID","
                   secret = "9f4d8d860c76d6386a5959496d73185f899d9733" # "My Client Secret",  
                   )
library(httpuv)
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
data_json <- content(req)

library(jsonlite)
data_fr <- jsonlite::fromJSON(jsonlite::toJSON(data_json))
names(data_fr)
data_fr[data_fr$full_name == "jtleek/datasharing", "created_at"] 

### Question 2
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile= "data_w2.csv")
acs <- read.csv("data_w2.csv", header=TRUE)

sqldf("select pwgtp1 from acs where AGEP \lt< 50")


### Question 3

unique(acs$AGEP) == sqldf("select unique * from acs")
unique(acs$AGEP) == sqldf("select AGEP where unique from acs")
unique(acs$AGEP) == sqldf("select distinct AGEP from acs")
unique(acs$AGEP) == sqldf("select distinct pwgtp1 from acs")


### Question 4
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlcode <- readLines(con)
close(con)
sapply(htmlcode, nchar)[c(10,20,30,100)]


### Question 5
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"


data <- read.fwf(file=url,widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4), skip = 4)
sum(data[, 4])
