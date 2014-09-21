#-----------------------------------------
# plot2.R
#-----------------------------------------
# Question 2: Have total emissions from PM2.5 decreased 
# in the Baltimore City, Maryland (fips == "24510") from 
# 1999 to 2008? Use the base plotting system to make a
# plot answering this question.
#-----------------------------------------

# source the helper script to download and verify
source("getData2.R")
# run the helper function and set things up
gatherData()

# National Emissions Inventory (NEI)
NEI<-readRDS("data/summarySCC_PM25.rds")

# Baltimore by code 24510
BaltimoreCity<-subset(NEI, fips == "24510")

# extract the emmisions by year
PMbyYear<-tapply(BaltimoreCity$Emissions, BaltimoreCity$year, sum)

#png("plot2.png")
png(filename = "plot2.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
plot(names(PMbyYear), PMbyYear, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions"),
     main=expression("Total Baltimore City" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
