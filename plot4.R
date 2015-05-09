#see which line correspond to the wanted dates
indices <- grep(c("^(1/2/2007|2/2/2007)"), readLines("household_power_consumption.txt"))

# read in only the data from the interesting dates
d <- read.table("household_power_consumption.txt", skip= indices[1]-1,nrows =length(indices),sep =";")

#create column names
colnames(d) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

# make dates 
d$timedate <- paste(d$Date, d$Time)
d = transform(d, timedate = strptime(d$timedate, "%d/%m/%Y %H:%M:%S"))

#plot

png("plot4.png")

par(mfrow = c(2,2))

with(d, plot(d$timedate,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

with(d, plot(d$timedate,Voltage, type = "l", xlab = "datetime",))

with(d, plot(timedate,Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = ""))
with(d, lines(timedate,Sub_metering_1))
with(d, lines(timedate,Sub_metering_2, col = "red"))
with(d, lines(timedate,Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(d, plot(d$timedate,Global_reactive_power, type = "l", xlab = "datetime"))

dev.off()
