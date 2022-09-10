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
png(file="plot4.png",width=480, height=480)

# plot 
par(mfrow = c(2, 2))

# upper left plot
with(household_power_consumption_2007_Feb, {
  plot(Date_Time, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power" )
  lines(Date_Time, Global_active_power)
})

# upper right plot
with(household_power_consumption_2007_Feb, {
  plot(Date_Time, Voltage, type = "n", xlab = "datetime", ylab = "Voltage" )
  lines(Date_Time, Voltage)
})


# lower left plot
with(household_power_consumption_2007_Feb, {
  plot(Date_Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering" )
  lines(Date_Time, Sub_metering_1)
  lines(Date_Time, Sub_metering_2, col = "red")
  lines(Date_Time, Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")
  
})

# lower right plot
with(household_power_consumption_2007_Feb, {
  plot(Date_Time, Global_reactive_power , type = "n", xlab = "datetime", ylab = "Global_reactive_power" )
  lines(Date_Time, Global_reactive_power )
})

# close png file
dev.off()


#free memory by deleting variables
rm(fileurl)
rm(household_power_consumption_2007_Feb)

