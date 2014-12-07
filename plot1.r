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

## Constructing the histogram
hist(subset_hpc$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

## Save graph to a file
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
