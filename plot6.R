#-----------------------------------------
# plot5.R
#-----------------------------------------
# Question 6: Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == 06037).
# Which city has seen greater changes over time in motor vehicle emissions?
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
# Source Classification Code (SCC)
SCC <- readRDS("data/Source_Classification_Code.rds")

# subset and preserve the records by fips code and type ON ROAD
VehiclesByCounty<-subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")
# transform by fips using ifelse to match with names either Baltimore or LA
VehiclesByCounty<-transform(VehiclesByCounty, region = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))
# use ddply to split by the emmisions by year and region and perform a sum
PMbyYearRegion <- ddply(VehiclesByCounty, .(year, region), function(x) sum(x$Emissions))
# set the colume name to Emisions
colnames(PMbyYearRegion)[3] <- "Emissions"

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "plot6.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
qplot(year, Emissions, data=PMbyYearRegion, geom="line", color=region) +
  ggtitle("Baltimore City and Los Angeles County\nMotor Vehicle Emissions by Year") +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))
dev.off()
