url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url,"nei_data.zip")
unzip("nei_data.zip")
source("plot1.R")
source("plot2.R")
source("plot3.R")
source("plot4.R")
# Total emissions in US from 1999-2008
plot1()
plot2()
plot3()


#plot2()
