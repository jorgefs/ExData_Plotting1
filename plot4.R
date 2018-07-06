# Load full file
power_consumption <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric") , na.strings=c("", "?"))

# Keep info from selected dates
power_consumption <- subset(power_consumption,Date %in% c("1/2/2007", "2/2/2007"))

# Create datetime column
power_consumption$Datetime <- strptime(paste(power_consumption$Date,power_consumption$Time), format="%d/%m/%Y %H:%M:%S")

# range in days (needed to replicate tick labels in the x-axis)
r <- as.POSIXct(round(range(power_consumption$Datetime),"days"))

# 
png(file="plot4.png", width = 480, height = 480, units = "px")

# There will be 4 plots in the png file
par(mfrow=c(2,2))

with(power_consumption, {
  # Active power graph
  plot(Datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  axis.POSIXct(1, at=seq(r[1], r[2], by = "day"), format="%a")
  
  # Voltage graph
  plot(Datetime, Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
  axis.POSIXct(1, at=seq(r[1], r[2], by = "day"), format="%a")
  
  # Submeterings graph
  plot(Datetime, Sub_metering_1, type="l", col="black", main="", ylab="Energy sub metering", xlab="", ylim=c(0,38))
  lines(Datetime, Sub_metering_2, col="red")
  lines(Datetime, Sub_metering_3, col="blue")
  legend("topright", bty="n", lty= c(1,1), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  # Reactive power graph
  plot(Datetime, Global_reactive_power, type="l", xlab="datetime", xaxt="n")
  axis.POSIXct(1, at=seq(r[1], r[2], by = "day"), format="%a")
})


dev.off()
