par(mfrow = c(1,1))

#see which lines correspond to the wanted dates
indices <- grep(c("^(1/2/2007|2/2/2007)"), readLines("household_power_consumption.txt"))

# read in only the data from the interesting dates
d <- read.table("household_power_consumption.txt", skip= indices[1]-1,nrows =length(indices),sep =";")

#create column names
colnames(d) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
head(d)

#plot
with(d, hist(Global_active_power,xlab = "Global Active Power (kilowatts)", col="red", main = "Global Active Power"))

#save
dev.copy(png, file = "plot1.png", w = 480, h = 480); dev.off()
