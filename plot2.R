# load libraries
library(data.table, quietly=TRUE)

## Read data and subset dates
cons <- fread("household_power_consumption.txt", na.strings="?")[Date=="1/2/2007" | Date=="2/2/2007"]

## change locale to English
Sys.setlocale("LC_TIME", "English")

## Convert Date and Time to classes Date and POSIXlt and add column Week_day
datetime <- strptime(paste(cons$Date, cons$Time),format="%d/%m/%Y %H:%M:%S")
cons$Date <- as.Date(cons$Date, format="%d/%m/%Y")
cons[,Week_day:=weekdays.Date(Date)]

## Plot graphic
png("plot2.png")
plot(datetime, cons$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.off()

## restore locale to Spanish
Sys.setlocale("LC_TIME", "Spanish")
