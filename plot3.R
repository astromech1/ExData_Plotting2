#-----------------------------------------
# plot3.R
#-----------------------------------------
# Question 3: Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of 
# these four sources have seen decreases in emissions from 
# 1999-2008 for Baltimore City? Which have seen increases in
# emissions from 1999-2008? Use the ggplot2 plotting system to make 
# a plot answer this question.
#-----------------------------------------
# library calls
library(plyr)
library(ggplot2)

# source the helper script to download and verify
source("getData2.R")
# run the helper function and set things up
gatherData()

# National Emissions Inventory (NEI)
NEI<-readRDS("data/summarySCC_PM25.rds")

# Baltimore by code 24510
BaltimoreCity<-subset(NEI, fips == "24510")
# extract the emmisions by year and type and perform a sum
PMbyYear<-ddply(BaltimoreCity, .(year, type), function(x) sum(x$Emissions))
# set the colume name to Emisions
colnames(PMbyYear)[3] <- "Emissions"

#png("plot3.png")
png(filename = "plot3.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
qplot(year, Emissions, data=PMbyYear, color=type, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
