setwd("C:/Users/Sumedha/datascience/datasciencecoursera/ExploratoryGraphs")
if (!file.exists(./Data))
{dir.create(./Data)}
downloadURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
downloadFile <- "./Data/exdata%2Fdata%2FNEI_data.zip"
if (!file.exists("./Data/summarySCC_PM25.rds")){
    download.file(downloadURL,downloadFile)
    unzip(downloadFile,overwrite = T,exdir ="./Data")
}
NEI <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")
data1999 <- subset(NEI,year>=1999&year<=2008)

baltData <- baltimoreData[,c(4,5,6)]

library(dplyr)
summedupBaltimore <- baltData %>% group_by(year,type) %>% summarise(totalemissions = sum(Emissions))
summedupBaltimore <- baltData %>% group_by(type) %>% summarise(totalemissions = sum(Emissions))
qplot(type,totalemissions,data=summedupBaltimore)
library(ggplot2)
qplot(year,totalemissions,data=summedupBaltimore,color=type)
qplot(year,totalemissions,data=summedupBaltimore,facets=.~type)
qplot(totalemissions,data=summedupBaltimore,facets=type~.,binwidth=2)
dev.copy(png,file="plot3.png")
dev.off()
