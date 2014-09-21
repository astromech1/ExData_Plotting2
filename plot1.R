#-----------------------------------------
# plot1.R
#-----------------------------------------
# Question 1: Have total emissions from PM2.5 decreased in the 
# United States from 1999 to # 2008? Using the base plotting 
# system, make a plot showing the total PM2.5 emission from all 
# sources for each of the years 1999, 2002, 2005, and 2008.
#-----------------------------------------

# source the helper script to download and verify
source("getData2.R")
# run the helper function and set things up
gatherData()

# National Emissions Inventory (NEI)
NEI<-readRDS("data/summarySCC_PM25.rds")
# extract the emmisions by year
PMbyYear<-tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
#png(filename = "plot1.png", 
#    width = 480, height = 480, 
#    units = "px", bg = "transparent")
plot(names(PMbyYear), PMbyYear, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()
