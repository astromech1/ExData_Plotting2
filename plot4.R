#-----------------------------------------
# plot3.R
#-----------------------------------------
# Question 4: Across the United States, how have 
# emissions from coal combustion-related
# sources changed from 1999-2008?
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
SCC<-readRDS("data/Source_Classification_Code.rds")

# Extract the source codes corresponding to coal combustion
CoalCodes<-subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal",
                                                  "Fuel Comb - Electric Generation - Coal",
                                                  "Fuel Comb - Industrial Boilers, ICEs - Coal"))

# Compare names, matching both Comb and Coal
CombustionCompare<-subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
# Found union works well to discard any duplicated values in the argument set
# and they apply as.vector to their arguments
CoalCodesUnion<-union(CoalCodes$SCC, CombustionCompare$SCC)
# subset and preserve the records by coal codes
CoalCombustion<-subset(NEI, SCC %in% CoalCodesUnion)
# use ddply to split and apply a sum on emissions
PMbyYear<-ddply(CoalCombustion, .(year, type), function(x) sum(x$Emissions))
# set the colume name to Emisions
colnames(PMbyYear)[3] <- "Emissions"

#png("plot4.png")
png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px", bg = "transparent")
qplot(year, Emissions, data=PMbyYear, color=type, geom="line") +
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
               color = "black", aes(shape="Total"), geom="line") +
  geom_line(aes(size="Total", shape = NA)) +
  ggtitle(expression("Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))
dev.off()
