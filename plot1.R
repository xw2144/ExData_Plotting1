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

### open png file
png("plot1.png", width=480, height=480)

### draw histogram
hist(epc$Global_active_power, breaks=seq(0,7.5,by=0.5), axes=FALSE,
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red", 
     )
axis(1, at=seq(0,6,by=2))
axis(2, at=seq(0,1200,by=200))

dev.off()
