library(XML)
#todo take it one level above and download best of each year or month.
# download best of 2012
setwd("C:\\Jasmit\\outlook_psts\\wallpapers\\2012")
#get the wallpaper link from the 2012 main page
#from the wall paper link, get the html source for the link and parse out download link.
#use the download link to download the jpg.  on windows, 'wb' is needed otherwise we get the 
# invalid image.

# main link
m  <- "http://photography.nationalgeographic.com"
link_2012= "http://photography.nationalgeographic.com/photography/photos/pod-best-wallpapers-of-2012"
doc <- htmlTreeParse(link_2012,useInternal=TRUE)
wall_links <- xpathSApply(doc,"//div//p[@class='wallpaper_link']/a",xmlGetAttr,"href")
# apply same function over each wallpaper link.  replacement for "for" loop.
lapply(wall_links, function(x) 
  {
    nl <- paste("http://photography.nationalgeographic.com",x,sep="") 
    d <- htmlTreeParse(nl,useInternal=TRUE)
    dlink <- xpathSApply(d,"//div[@class='download_link']/a",xmlGetAttr,"href")
    fileUrl <- paste("http:",dlink[1],sep="") 
    # download it as same name as the orig file name.
    download.file(fileUrl,basename(fileUrl),mode='wb')
  }
)