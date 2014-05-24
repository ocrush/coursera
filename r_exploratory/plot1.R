## Have total emissions from PM decreased in the United States from 1999 to 2008? 

## read data from NEI file
## sum up total emissions per year
## save plot as png

# assumes data is available in the current directory
plot1 <- function() {
  NEI = readRDS("summarySCC_PM25.rds")

  # total emissions per year
  e_per_year <- aggregate(Emissions ~ year, data=NEI,sum)
  png(filename= "plot1.png")
  plot(e_per_year$Emissions,type='l',xaxt='n',
     xlab="Years",
     ylab=("PM2.5 (in tons)"),
     main="Total PM2.5 From All Sources (1999-2008)")
  axis(1,at=1:4,labels=e_per_year$year)
  dev.off()
}
plot1()
