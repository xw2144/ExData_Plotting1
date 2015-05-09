library(data.table)

### number of lines for 16/12/2006
n1 <- 397 

### number of lines from 16/12/2006 to 01/02/2007
n2 <- (as.Date("2007-01-31") - as.Date("2006-12-16"))*60*24 

### read in 01/02/2007 and 02/02/2007 data
epc <- fread("household_power_consumption.txt", skip = n1+n2, nrow = 60*24*2, 
             na.string = "?")

### add column names to epc data table
epc.r1 <- fread("household_power_consumption.txt", nrow=1)
setnames(epc, names(epc.r1))

### format date and time
datetime <- strptime(paste(epc$Date, epc$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

### open png file
png("plot4.png", height=480, width=480)

### open 4 plot windows
par(mfcol=c(2,2))

### plot global active power vs date/time
plot(datetime, epc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

### plot submetering1-3 vs date/time
plot(datetime, epc$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(datetime, epc$Sub_metering_2, col="red")
lines(datetime, epc$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")

### plot voltage vs date/time
plot(datetime, epc$Voltage, type="l", ylab="Voltage")

### plot global reactive power vs date/time
plot(datetime, epc$Global_reactive_power, type="l", ylab="Global_reactive_power",
     yaxt="n")
axis(2, at=seq(0.0, 0.5, by=0.1))

dev.off()
