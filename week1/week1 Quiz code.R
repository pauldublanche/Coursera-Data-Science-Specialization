### Question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",
              destfile= "./data.csv")

data <- read.csv("./data.csv", header=TRUE)
table(data$VAL)["24"]


### Question 3
library(xlsx)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              destfile="./data2.xlsx")

dat <- read.xlsx("./data2.xlsx",
                 sheetIndex=1,
                 header=TRUE,
                 colIndex=7:15,
                 rowIndex=18:23)
sum(dat$Zip*dat$Ext,na.rm=T)


### Question 4
library(XML)
data3 <- xmlTreeParse("http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
                      useInternal = TRUE)
rootnode <- xmlRoot(data3)
sum(xpathSApply(rootnode,"//zipcode",xmlValue) == 21231)

### Question 5
library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "./data4.csv")
DT <- fread("./data4.csv")

system.time(DT[,mean(pwgtp15),by=SEX])[1]
system.time(tapply(DT$pwgtp15,DT$SEX,mean))[1]
system.time(rowMeans(DT)[DT$SEX==1])[1] + system.time(rowMeans(DT)[DT$SEX==2])[1]
system.time(mean(DT[DT$SEX==1,]$pwgtp15))[1] + system.time(mean(DT[DT$SEX==2,]$pwgtp15))[1]
system.time(mean(DT$pwgtp15,by=DT$SEX))[1]
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))[1]
