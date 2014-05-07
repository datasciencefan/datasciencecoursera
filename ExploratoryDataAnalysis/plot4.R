#Download and exctract data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), skip = 66637, nrows=2880, sep=";")
dataHeader <- read.table(unz(temp, "household_power_consumption.txt"),header=1, nrows=1, sep=";")
unlink(temp)

#Add column names to data
colnames(data) <- colnames(dataHeader)

#Combine Date and Time columns
newdata <- data[,1:9]
newdata$Time <- paste(data$Date, data$Time, sep=" ")
newdata$Time <- strptime(newdata$Time, format = "%d/%m/%Y %H:%M:%S")
head(newdata$Time)

#Plot and save the graph in png form
png(file = "plot4.png")
par(mfrow = c(2,2))

#Plot1
with(newdata, plot(Time, Global_active_power, xlab = "", ylab = "Global Active Power", type = "l"))

#Plot2
with(newdata, plot(Time, Voltage, xlab = "datetime", ylab = "Voltage", type = "l"))

#Plot3
with(newdata, plot(Time, Sub_metering_1, ylab = "Energy sub metering", xlab="", type = "l"))
with(newdata, points(Time, Sub_metering_2, type = "l", col = "red"))
with(newdata, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", pch = "_", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

#Plot4
with(newdata, plot(Time, Global_reactive_power, xlab = "datetime", ylab = "GLobal_reactive_power", type = "l"))

dev.off()
