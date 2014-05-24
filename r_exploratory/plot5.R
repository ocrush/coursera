## How have emissions from motor vehicle sources changed from 
## 1999-2008 in Baltimore City?

## for this study "ON-ROAD" is considered to be a motor vehicle.
## subset NEI according to Baltimore
## Further subset Baltimore data according to ON-ROAD
## sum up emissions according to year.

plot5 <- function()
{
  NEI = readRDS("summarySCC_PM25.rds")
  #subset according to baltimore 
  balEmissions <- subset(NEI,NEI$fips == "24510")
  # emissions by ON-ROAD
  balMotorData <- aggregate(Emissions ~ year, 
                  data=(subset(
                    balEmissions,
                    balEmissions$type=="ON-ROAD"
                    )),
                    sum)
  png(filename="plot5.png")
  plot(balMotorData$Emissions,type='l',xaxt='n',
       xlab="Years",
       ylab=("PM2.5 (in tons)"),
       main="Total Emissions From Motor Vehicle in Baltimore")
  axis(1,at=1:4,labels=balMotorData$year)
  dev.off()
}
plot5()