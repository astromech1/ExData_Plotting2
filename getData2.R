#-----------------------------------------
# getData.R
#-----------------------------------------
# Download the zip file and extract the 
#   files and put them in the appropriate 
#   directories.
#-----------------------------------------
# for Windows users only, this allows the use 
#   of Internet Explorer for Internet access
setInternet2(TRUE)

# function to be called by all other plot files
gatherData<-function() {
  # variables
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  filePath <- "./data/exdata%2Fdata%2FNEI_data.zip"
  
  # check to see if the data directory exists
  if (!file.exists("data")) {
    dir.create("data")
  }
  
  # check for the zip files and
  # download the file only if necessary
  if (!file.exists(filePath)) {
    download.file(fileUrl, destfile = filePath)
    dateDownloaded <- date()
    dateDownloaded
    
    # Unzip the file
    unzip(filePath, exdir="./data")
  }
}