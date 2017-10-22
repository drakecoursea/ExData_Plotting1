##### Assignment 1 Plot 3 #####

### Main Code ###

# Download the dataset
# Extract out the file and place it in your default working directory

# Estimate memory required (should be enough)
(2075259*9*8)/(2^20)

# Read data in
d <- read.table("household_power_consumption.txt", header=T, sep=";", na.strings="?")

# Change format to date
d$Date <- as.Date(d$Date, "%d/%m/%Y")

# Filter out the required dates
d <- subset(d, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Combine Date and Time column
DateTime <- paste(d$Date, d$Time)

# Name the vector
DateTime <- setNames(DateTime, "DateTime")

# Remove Date and Time column
d <- d[ ,!(names(d) %in% c("Date","Time"))]

# Add DateTime column
d <- cbind(DateTime, d)

# Format dateTime Column
d$DateTime <- as.POSIXct(DateTime)


# Check if any NA remaining
mean(d$Global_active_power)
mean(d$Global_reactive_power)
mean(d$Voltage)
mean(d$Global_intensity)
mean(d$Sub_metering_1)
mean(d$Sub_metering_2)
mean(d$Sub_metering_3)

is.na(d$DateTime) -> nacounter
sum(nacounter)
# Verified that all NA values have been removed
rm(nacounter)



# Plot 3

with(d, plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab=""))
with(d, lines(Sub_metering_2~DateTime,col='Red'))
with(d, lines(Sub_metering_3~DateTime,col='Blue'))
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), lty=c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
