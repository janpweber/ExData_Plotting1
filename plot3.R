#workingdirectory <- "ENTER_YOUR_WORKINGDIRECTORY"
#setwd(workingdirectory)

## libraries needed:
#library(dplyr)
#library(lubridate) #easy handling of dates

## load data:
## This script requires you to have the data downloaded from: 
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## and have this zip-File in the folder "data" in your working directory
## no need to unzip the file, this is handled by the script

## if you have not downloaded the file, the following code (commented out) will make it available to you.
## skip the next two lines of code;
## otherwise proceed with the non-commented-out code
# temp <- tempfile()
# fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileURL, temp) # may need method = "curl" on Mac
# connection <- unz(temp, "household_power_consumption.txt")
# data <- read.table(connection, sep=";", na.strings="?", header = T)
# unlink(temp)
# rm(temp)

connection <- unz("./data/exdata_data_household_power_consumption.zip", "household_power_consumption.txt")
data <- read.table(connection, sep=";", na.strings="?", header = T)

## subset to 2007-02-01 and 2007-02-02
datasubset <- rbind(data[data$Date == "1/2/2007",],
                    data[data$Date == "2/2/2007",])

## compute a new variable for date&time
datasubset <- mutate(datasubset, Date_and_Time = dmy_hms(paste(Date, Time)))

################################################################################
## plot 3:
par(mfrow = c(1,1))                 # make sure to generate a single graph
Sys.setlocale("LC_TIME", "English") # sets the locale to English for axis labels

png(filename = "plot3.png", width = 480, height = 480) #open a connection to a png file
plot(type = "n",
     x = datasubset$Date_and_Time, 
     y = datasubset$Sub_metering_1,
     #ylim = 30, 
     main = NULL,
     xlab = " ",
     ylab = "Energy sub metering",
     #col="red",
     bg = "transparent")
lines(datasubset$Date_and_Time, datasubset$Sub_metering_1, col="black")
lines(datasubset$Date_and_Time, datasubset$Sub_metering_2, col="red")
lines(datasubset$Date_and_Time, datasubset$Sub_metering_3, col="blue")
legend("topright",  
       lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"))
dev.off() # close the connection to the png file

