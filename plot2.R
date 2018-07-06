# Load full file
power_consumption <- read.csv("household_power_consumption.txt", sep=";", colClasses=c("factor","factor","numeric","numeric","numeric","numeric","numeric","numeric","numeric") , na.strings=c("", "?"))

frame_size <- object.size(power_consumption)

cat('Loading all lines in file has required ')
print(frame_size, units="auto")

# Keep info from selected dates
power_consumption <- subset(power_consumption,Date %in% c("1/2/2007", "2/2/2007"))

# Create datetime column
power_consumption$Datetime <- strptime(paste(power_consumption$Date,power_consumption$Time), format="%d/%m/%Y %H:%M:%S")

png(file="plot2.png", width = 480, height = 480, units = "px")
plot(power_consumption$Datetime, power_consumption$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")

# range in days
r <- as.POSIXct(round(range(power_consumption$Datetime),"days"))
axis.POSIXct(1, at=seq(r[1], r[2], by = "day"), format="%a")

dev.off()