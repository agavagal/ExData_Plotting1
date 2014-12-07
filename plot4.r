## This program assumes that the source data file is available in the working directory
## Set java parameters to avoid space constraints before reading data from file
options(java.parameters = "-Xmx4g")

## Read and subset data
hpc <- read.csv2("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",
                 stringsAsFactors = FALSE, comment.char="", quote='\"')
subset_hpc <- subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")
subset_hpc$Date <- as.Date(subset_hpc$Date, format = "%d/%m/%Y")
subset_hpc$datetime <- paste(subset_hpc$Date, subset_hpc$Time)
subset_hpc$datetime <- as.POSIXct(subset_hpc$datetime)
subset_hpc$Global_active_power <- as.numeric(subset_hpc$Global_active_power, length = 3)

# Setting global variables to allow for 4 graphs
par(mar = c(4,4,1,1), oma = c(0,0,2,0))
par(mfrow = c(2,2))

## Constructing the first plot
plot(subset_hpc$datetime, subset_hpc$Global_active_power, type = "l", xlab = "",
     ylab = "Global Active Power")

plot(subset_hpc$datetime, subset_hpc$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

with(subset_hpc, {plot(subset_hpc$Sub_metering_1 ~ subset_hpc$datetime, type = "l", xlab = "",
                       ylab = "Energy sub metering", col = "black")
                  lines(subset_hpc$Sub_metering_2 ~ subset_hpc$datetime, col = "red")
                  lines(subset_hpc$Sub_metering_3 ~ subset_hpc$datetime, col = "blue")
                  legend("topright", col = c("black","red", "blue"), lty = 1, lwd = 2, cex = 0.4,
                         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

plot(subset_hpc$datetime, subset_hpc$Global_reactive_power, type = "l", xlab = "datetime",
     ylab = "Global_reactive_power")

## Save graph to a file
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
