# Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999-2008?

## From SCC data, get SCC codes for coal combustion-related
## subset NEI data according to coal combustion-related SCC codes.
## total Emissions per year for coal.
## plot data
## save as png.
plot4 <- function()
{
  NEI = readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  #After reading several discussion posts.  agreed on the following coal combustion
  coalComb <- SCC[grepl("coal", 
                  SCC$SCC.Level.Three, ignore.case=TRUE) | 
                  grepl("Lignite", SCC$SCC.Level.Three, 
                  ignore.case=TRUE),]
  #subset NEI according to coalcomb
  neiCoalData <- NEI[(NEI$SCC %in% coalComb$SCC),]
  coalPerYear <- aggregate(Emissions ~ year, data=neiCoalData,sum)
  png(filename="plot4.png")
  plot(coalPerYear$Emissions,type='l',xaxt='n',
       xlab="Years",
       ylab=("PM2.5 (in tons)"),
       main="Total Emissions from coal combustion-related sources")
  axis(1,at=1:4,labels=coalPerYear$year)
  dev.off()
}
plot4()
  
}