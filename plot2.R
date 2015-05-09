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
png("plot2.png", width=480, height=480)

### plot global active power vs date/time
plot(datetime, epc$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()