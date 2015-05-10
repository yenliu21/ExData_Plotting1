dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataset_url, "household_power_consumption.zip")
unzip("household_power_consumption.zip")

data <- read.table("household_power_consumption.txt",header=FALSE, sep=";", na.strings="?"
                   ,skip=grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt"))
                   ,nrows=2880,col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

data$NewDate <- paste(data$Date,data$Time)
data <- transform(data, NewDate=strptime(NewDate, format="%d/%m/%Y %H:%M:%S"))

##Plot 3
png("plot3.png")
plot(data$NewDate,data$Sub_metering_1, xlab="", ylab="Energy sub metering", type="n")
lines(data$NewDate,data$Sub_metering_1,)
lines(data$NewDate,data$Sub_metering_2,col="red")
lines(data$NewDate,data$Sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
