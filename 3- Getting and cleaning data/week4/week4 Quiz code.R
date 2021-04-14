if (!file.exists("./week4")){dir.create("./week4")}

### Question 1

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url, destfile = "./week4/data1.csv")
data1 <- read.csv("./week4/data1.csv", header=TRUE)
dim(data1)
strsplit(names(data1), "wgtp")[[123]]


### Question 2

url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(url2, destfile = "./week4/FGDP.csv")
FGDP <- read.csv("./week4/FGDP.csv", header=TRUE)
FGDP <- FGDP[5:194,]
FGDP$X.3 <- gsub(",","",FGDP$X.3)
mean(as.numeric(FGDP$X.3))


### Question 3

names(FGDP)[4] <- "countryNames"

length(grep("^United",FGDP$countryNames))
# Would also work with length(grep("*United",FGDP$countryNames))


### Question 4

url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url3, destfile = "./week4/country.csv")
country <- read.csv("./week4/country.csv")

df <- merge(x=FGDP, y=country, by.x='X', by.y='CountryCode')
length(grep("Fiscal year end: June 30;", df$Special.Note))


### Question 5

library(lubridate)
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

obs_2012 = format(sampleTimes, format = "%Y")=="2012"
sum(obs_2012)

sum(wday(sampleTimes[obs_2012])==2)

