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
baltimoreData <- subset(data1999, fips=="24510")
baltData <- baltimoreData[,c(4,6)]
summedupBaltimore <- aggregate(baltData,list(Year=baltimoreData$year),sum)
plot(summedupBaltimore$Year, summedupBaltimore$Emissions,pch=18,cex=2,type="b",xlab = "Year",
     ylab="Emissions (in tons)", main="Baltimore City Emissions",xaxt="n")
axis(side=1, c("1999","2002","2005","2008"))
dev.copy(png,file="plot2.png")
dev.off()
