#Download and exctract data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), skip = 66637, nrows=2880, sep=";")
dataHeader <- read.table(unz(temp, "household_power_consumption.txt"),header=1, nrows=1, sep=";")
unlink(temp)

#Add column names to data
colnames(data) <- colnames(dataHeader)

#Combine Date and Time columns
newdata <- data[,2:9]
newdata$Time <- paste(data$Date, data$Time, sep=" ")
newdata$Time <- strptime(newdata$Time, format = "%d/%m/%Y %H:%M:%S")

#Plot the graph and save in png form
png(file = "plot1.png")
with(newdata, hist(Global_active_power, breaks = 14, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()


