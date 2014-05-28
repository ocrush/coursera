require(sqldf)
query = "select EVTYPE, FATALITIES, INJURIES,PROPDMG,PROPDMGEXP,CROPDMG,CROPDMGEXP from file"  
cols = rep("NULL",37)
cols[c(8,23,24,25,26,27,28)]=NA
data <- read.csv("repdata-data-StormData.csv",colClasses=cols)
fatPerEvent <- aggregate(FATALITIES ~ EVTYPE,data=data,sum)
injPerEvent <- aggregate(INJURIES ~ EVTYPE,data=data,sum)
popImpact <- merge(fatPerEvent,injPerEvent,by="EVTYPE")
popImpact$total <- popImpact$FATALITIES + popImpact$INJURIES
popImpact <- popImpact[with(popImpact,
                            order(FATALITIES,INJURIES,
                            decreasing=TRUE)),]
injPerEvent <- injPerEvent[with(injPerEvent,
                                order(INJURIES,
                                      decreasing=TRUE)),]
pdata=zz[1:20,]
#display top 20
require(ggplot2)
p <- ggplot(popImpact[1:10,],
            aes(x=EVTYPE,y=FATALITIES,fill=EVTYPE),height=580)
p <- p + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("Number Of Fatalities") +
  ggtitle("Top 10 Events for Fatalities")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p2 <- ggplot(injPerEvent[1:10,],
             aes(x=EVTYPE,y=INJURIES,fill=EVTYPE),
             height=580)
p2 <- p2 + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("Number Of Injuries") +
  ggtitle("Top 10 Events for Injuries")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

p3 <- ggplot(popImpact[1:10,],
             aes(x=EVTYPE,y=total,fill=EVTYPE),
             height=580)
p3 <- p3 + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("total impact") +
  ggtitle("Top 10 Events for overall impact")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
require(gridExtra)
grid.arrange(p,p2,p3,ncol=2)

# property damage
propDamage <- subset(data,PROPDMGEXP %in% c("K","M","B","m","k"))
cropDamage <- subset(data,CROPDMGEXP %in% c("K","M","B","m","k"))

mapDollar <- data.frame(exp=factor(c("K","M","B","m","k")),
                        value=c(1e3,1e6,1e9,1e6,1e3))
propDamage$dollarCost <- mapDollar$value[
                          match(propDamage$PROPDMGEXP,
                                mapDollar$exp)]

propDamage$dollarCost <- propDamage$dollarCost * propDamage$PROPDMG

propDamagePerType <- aggregate(dollarCost ~ EVTYPE,
                               data=propDamage,sum)
propDamagePerType <- propDamagePerType[with(propDamagePerType,
                                            order(dollarCost,
                                                  decreasing=TRUE)
                                            ),
                                       ]
#crop damage cost
cropDamage$dollarCost <- mapDollar$value[
  match(cropDamage$CROPDMGEXP,
        mapDollar$exp)]

cropDamage$dollarCost <- cropDamage$dollarCost * cropDamage$CROPDMG

cropDamagePerType <- aggregate(dollarCost ~ EVTYPE,
                               data=cropDamage,sum)
cropDamagePerType <- cropDamagePerType[with(cropDamagePerType,
                                            order(dollarCost,
                                                  decreasing=TRUE)
                                            
                                            ),
                                      ]
economyImpact <- merge(propDamagePerType,
                       cropDamagePerType,
                       by="EVTYPE",
                       all=TRUE)
economyImpact$total <- economyImpact$dollarCost.x + 
                        economyImpact$dollarCost.y
economyImpact <- economyImpact[with(economyImpact,
                       order(total,
                             decreasing=TRUE)
                       
                      ),
                      ]
require(ggplot2)
# visualize - plot data
ep <- ggplot(propDamagePerType[1:10,],
            aes(x=EVTYPE,y=dollarCost,fill=EVTYPE),height=580)
ep <- ep + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("property damage($)") +
  ggtitle("Prop Damage(Top 10)")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ep2 <- ggplot(cropDamagePerType[1:10,],
             aes(x=EVTYPE,y=dollarCost,fill=EVTYPE),
             height=580)
ep2 <- ep2 + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("crop damage($)") +
  ggtitle("Crop Damage (Top Ten)")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ep3 <- ggplot(economyImpact[1:10,],
             aes(x=EVTYPE,y=total,fill=EVTYPE),
             height=580)
ep3 <- ep3 + geom_bar(stat="identity",position="dodge",colour="black")+
  guides(fill=FALSE) +
  xlab("Event Type") + 
  ylab("total impact($)") +
  ggtitle("Economy Impact (Top 10) ")  +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
require(gridExtra)
grid.arrange(ep,ep2,ep3,ncol=2)



