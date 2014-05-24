## Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in 
## Los Angeles County, California ( fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle 
## emissions?

## subset data according to Baltimore and LA
## further subset according to motor vehicle ("ON-ROAD")
## get percentage change since 1999 for both Baltimore and LA.  That
## is percentage change in 2002 compare to 1999, percentage change
## in 2005 compare to 1999.
## plot both Bal and LA percentage change on one chart to show
## comparsion.

plot6 <- function()
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
  #subset according to baltimore 
  laEmissions <- subset(NEI,NEI$fips == "06037")
  # emissions by ON-ROAD
  laMotorData <- aggregate(Emissions ~ year, 
                            data=(subset(
                              laEmissions,
                              laEmissions$type=="ON-ROAD"
                            )),
                            sum)
  # percentage change since 1999
  balMotorData$perchange <- ((balMotorData$Emissions - 
                               head(balMotorData$Emissions,1)) /
                               head(balMotorData$Emissions,1))*100
  
  laMotorData$perchange <- ((laMotorData$Emissions - 
                              head(laMotorData$Emissions,1)) /
                              head(laMotorData$Emissions,1))*100
  png(filename= "plot6.png")
  p <- ggplot() + 
    geom_line(data = balMotorData, aes(x = year, y = perchange, color = "Baltimore")) +
    geom_line(data = laMotorData, aes(x = year, y = perchange, color = "LA"))  +
    xlab('year') +
    ylab('percent change') +
    labs(color="Legend") +
    ggtitle("Percent Change Since 1999")
  print(p)  
  dev.off()
}
plot6()