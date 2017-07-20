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
pollutionDAta <- data1999[,c(4,6)]
##summedUpData <- sapply(split(pollutionDAta,pollutionDAta$year),sum)
summedupData <- aggregate(pollutionDAta,list(Year = pollutionDAta$year),sum)
plot(summedupData$Year,summedupData$Emissions/1000, main="Total US Emissions (in 1000 tons) ", ylab = "Emissions (1000 tons)", xlab = "Year",xaxt="n",type="b")
axis(1, at=c("1999","2002","2005","2008"))
dev.copy(png,file="plot1.png")
dev.off()
