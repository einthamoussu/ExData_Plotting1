library(dplyr)
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

# code for downloading and unzipping file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,"HouseholdPowerConsumption.zip")
unzip("HouseholdPowerConsumption.zip")

household_power_consumption_raw <- read.csv("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")


# from raw file, extract information from 01/02/2007 and 02/02/2007
household_power_consumption_2007_Feb <- filter(household_power_consumption_raw,grepl("(^[1]|^[2])/2/2007",household_power_consumption_raw$Date))

#free memory by deleting household_power_consumption_raw data frame
rm(household_power_consumption_raw)

#Create new column with Date+Time
household_power_consumption_2007_Feb <- mutate(household_power_consumption_2007_Feb, Date_Time = paste(Date,Time))

#Convert Date_Time from char to POSIXlt
household_power_consumption_2007_Feb <- mutate(household_power_consumption_2007_Feb, Date_Time = strptime(Date_Time,"%d/%m/%Y %H:%M:%S"))

#Overrite Dataframe by dropping individual Date column and Time column
household_power_consumption_2007_Feb <- select(household_power_consumption_2007_Feb, Date_Time, Global_active_power:Sub_metering_3) 

#PLOT
# opens png file
png(file="plot3.png",width=800, height=600)

# plot 
with(household_power_consumption_2007_Feb, {
  plot(Date_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering" )
  lines(Date_Time, Sub_metering_1)
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
 })
# close png file
dev.off()


#free memory by deleting variables
rm(fileurl)
rm(household_power_consumption_2007_Feb)


