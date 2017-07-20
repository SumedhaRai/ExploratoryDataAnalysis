cvsetwd("C:/Users/Sumedha/datascience/datasciencecoursera/ExploratoryGraphs")
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
baltimoreData <- subset(data1999, fips=="24510")
baltData <- baltimoreData[,c(4,5,6)]
library(dplyr)
summedupBaltimore <- baltData %>% group_by(year,type) %>% summarise(totalemissions = sum(Emissions))
library(ggplot2)
g <- ggplot(data=summedupBaltimore, aes(year,totalemissions))
g + geom_point() + aes(color=type) + geom_line() + labs(x="Year", y="Emissions (in tons)", title="T")
dev.copy(png,"Plot3.R")
dev.off()
##summedupBaltimore <- baltData %>% group_by(type) %>% summarise(totalemissions = sum(Emissions))
##qplot(type,totalemissions,data=summedupBaltimore)

dev.copy(png,file="plot3.png")
dev.off()
