#-----------------------------------------
# plot5.R
#-----------------------------------------
# Question 5: How have emissions from motor vehicle sources 
# changed from 1999-2008 in Baltimore City?
#-----------------------------------------
# library calls
library(plyr)
library(ggplot2)

# Read the data file
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("data/summarySCC_PM25.rds")
# Source Classification Code (SCC)
SCC <- readRDS("data/Source_Classification_Code.rds")

# Assume "Motor Vehicles" only means on road
BaltimoreCity <- subset(NEI, fips == "24510" & type=="ON-ROAD")
# use ddply to split by year and apply a sum on emissions
PMbyYear <- ddply(BaltimoreCity, .(year), function(x) sum(x$Emissions))
# set the colume name to Emisions
colnames(PMbyYear)[2] <- "Emissions"

#png("plot5.png")
png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
qplot(year, Emissions, data=PMbyYear, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Motor Vehicle Emissions by Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
