if (!file.exists("./week3")){dir.create("./week3")}

### Question 1
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url,destfile = "./week3/data1.csv")
data1 <- read.csv("./week3/data1.csv", header = T)

View(head(data1))

logical_vector <-  data1$ACR == 3 & data1$AGS == 6
# useless bc of the which
logical_vector[is.na(logical_vector)] <- FALSE
which(logical_vector)
### Answer =  125, 238,262


### Question 2
library(jpeg)
url2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(url2,destfile = "./week3/pic.jpg", mode="wb")
pic <- readJPEG("./week3/pic.jpg",native=TRUE)
quantile(pic, probs=c(0.3,0.8))
### Answer = -15258512 -10575416 

### Question3:
library(dplyr)
url3 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url4 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(url3,destfile = "./week3/GDP.csv")
download.file(url4,destfile = "./week3/educ.csv")

GDP <- read.csv("./week3/GDP.csv", skip=4, header = TRUE)
educ <- read.csv("./week3/educ.csv", header = TRUE)
View(GDP)
# Observations below the 190th are not ranked
# and the others columns are useless
GDP <- GDP[1:190,c(1,2)]
names(GDP)<- c("CountryCode","Ranking")

merged_data <- merge(GDP, educ, by= "CountryCode")
length(merged_data$Ranking)

merged_data$Ranking <- as.numeric(merged_data$Ranking)
ordered_data <- arrange(merged_data, desc(Ranking))
ordered_data[13, "Long.Name"]

### Question 4
library(data.table)

grouped_data <- group_by(merged_data, Income.Group)
summarize(grouped_data, mean(Ranking))

### Question 5
View(merged_data)

merged_data$Quantile <- cut(merged_data$Ranking,
                            breaks = quantile(merged_data$Ranking, 
                                              probs=seq(0,1,0.2),
                                              na.rm = TRUE))

table(merged_data[merged_data$Income.Group == "Lower middle income","Income.Group"],
      merged_data[merged_data$Income.Group == "Lower middle income","Quantile"])