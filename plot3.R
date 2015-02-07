## load package data.table
require(data.table)

## read the data file using fread for speed
powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

## we only need data for 2 days. So extracting only the required data.
powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

## converting from data.table to data .frame
plot3DF <- as.data.frame(powerConsumptionDFFilter)

## subsetting to select only required columns.
## this makes it easy to view the data. 
plot3DF <- subset(plot3DF, select = c(1,2,7,8,9))

## create a new column combining Date and Time and then converting it to POSIXlt
plot3DF$DateTime <- strptime(paste(plot3DF$Date,plot3DF$Time), "%d/%m/%Y %H:%M:%S")

## converting the character column to numeric
plot3DF$Sub_metering_1 <- as.numeric(plot3DF$Sub_metering_1)
plot3DF$Sub_metering_2 <- as.numeric(plot3DF$Sub_metering_2)
plot3DF$Sub_metering_3 <- as.numeric(plot3DF$Sub_metering_3)

## create a plot.
## Initialize the png file device.
png("plot3.png", width=480, height=480, bg="white")

## create the plot here.
## we want to superimpose all the three plots in one plot.
plot(plot3DF$DateTime,plot3DF$Sub_metering_1, type="l", ylab="Energy Sub metering", xlab="", col="grey")
lines(plot3DF$DateTime,plot3DF$Sub_metering_2, col="red")
lines(plot3DF$DateTime,plot3DF$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), lwd=c(2.5, 2.5, 2.5) , 
       col = c("grey", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_3", "Sub_metering_3"))

## Close the PNG graphics device.
dev.off()

## Little bit of housekeeping here.
## This will remove the variables created by this program from the environment.
remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot3DF)

## Unload data.table package
detach("package:data.table", unload=TRUE)