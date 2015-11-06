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

## Plot graphics
png("plot4.png")
par(mfrow=c(2,2))

plot(datetime, cons$Global_active_power, xlab="", ylab="Global Active Power", type="l")

plot(datetime, cons$Voltage, ylab="Voltage", type="l")

plot(datetime, cons$Sub_metering_1, ylim=c(0,38), xlab="", ylab="Energy sub metering", type="n")
lines(datetime, cons$Sub_metering_1, col="black")
lines(datetime, cons$Sub_metering_2, col="red")
lines(datetime, cons$Sub_metering_3, col="blue")
legend("topright", bty="n", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(datetime, cons$Global_reactive_power, ylab="Global_reactive_power", type="l")

dev.off()

## restore locale to Spanish
Sys.setlocale("LC_TIME", "Spanish")
