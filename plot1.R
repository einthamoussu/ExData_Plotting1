library(dplyr)

# code for downloading and unzipping file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,"HouseholdPowerConsumption.zip")
unzip("HouseholdPowerConsumption.zip")

household_power_consumption_raw <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")


# from raw file, extract information from 01/02/2007 and 02/02/2007
household_power_consumption_2007_Feb <- filter(household_power_consumption_raw,grepl("(^[1]|^[2])/2/2007",household_power_consumption_raw$Date))


#PLOT
# opens png file
png(file="plot1.png",width=480, height=480)

# write histogram
hist(household_power_consumption_2007_Feb$Global_active_power, col = "red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#close png file
dev.off()


#free memory by deleting variables
rm(fileurl)
rm(household_power_consumption_raw)
rm(household_power_consumption_2007_Feb)


