##########################################################################################################
# 
#   Course: 
#      Exploratory Data Analysis
#      by Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD
#
#   Harvey Siewert
#
#   5 May 2015
#   
#   Course Project 1
#
#   Plot 2   -  plot2.R   generates   plot2.png
#
#   Project URL: 
#     https://class.coursera.org/exdata-014/human_grading/view/courses/973508/assessments/3/submissions
#   
#   Data: 
#     https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
##########################################################################################################

# Path to the data file. The original file URL can be found above
dataFile <- "/Users/hsiewert/Dropbox/Scripts/Scripts_R/rAnProj1/household_power_consumption.txt" 

# Load libraries to be used later
library(dplyr)
library(lubridate)

# Set the working directory for the script. 
# Change this to meet your needs.
setwd("/Users/hsiewert/Dropbox/Scripts/Scripts_R/rAnProj1/ExData_Plotting1")

# Read the data file
# The file is quite large so this will take some time
myRawData <- read.table(dataFile,
                        header = TRUE, 
                        sep = ";",
                        stringsAsFactors=FALSE, 
                        na.strings="?",
                        skipNul = TRUE
)


# Extract values from the raw data file
# where the dates are between
# 2007-02-01 and 2007-02-02
# then destroy the original myRawData variable
myData <- myRawData[which(myRawData$Date == "1/2/2007" | myRawData$Date == "2/2/2007"),]
rm(myRawData)

# Define our output file for the plot
png(filename = "plot2.png", width = 480, height = 480 )

# Create a copy of the data that includes a combined DateTime column
# created from the Date and Time calumns by using dplyr and lubridate
myData2 <- mutate(myData, DateTimeStamp = dmy_hms(paste(myData$Date,myData$Time)))

# Assign the values for the nexts plot to the x and y variables
# Then plot and add the lines 
x <- myData2$DateTimeStamp
y <- myData2$Global_active_power
plot(x, y, type="n", xlab="",ylab="Global Active Power (kilowatts)" ) 
lines(x,y)

# Turn the PNG output device off
dev.off()
