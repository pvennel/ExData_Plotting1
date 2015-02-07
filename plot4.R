## If you so choose to run this program, I want to let you know that
## there is some housekeeping code which will clean up the environment 
## of any variables after the program has completed execution. 


## load package data.table
require(data.table)

## read the data file using fread for speed
## Suppress warnings from fread as it is ok at this time. 
powerConsumptionDT <- suppressWarnings(fread("household_power_consumption.txt", sep=";"))

## we only need data for 2 days. So extracting only the required data.
powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

## converting from data.table to data .frame
plot4DF <- as.data.frame(powerConsumptionDFFilter)

## converting the character column to numeric
plot4DF$Global_active_power <- as.numeric(plot4DF$Global_active_power)
plot4DF$lobal_reactive_power <- as.numeric(plot4DF$lobal_reactive_power)
plot4DF$Voltage <- as.numeric(plot4DF$Voltage)
plot4DF$Sub_metering_1 <- as.numeric(plot4DF$Sub_metering_1)
plot4DF$Sub_metering_2 <- as.numeric(plot4DF$Sub_metering_2)

## create a new column combining Date and Time and then converting it to POSIXlt
plot4DF$DateTime <- strptime(paste(plot4DF$Date,plot4DF$Time), "%d/%m/%Y %H:%M:%S")

## create a plot.
## Initialize the png file device.
png("plot4.png", width=480, height=480, bg="white")

## configuring to display 4 plots, with 2 plots per row.
## mar sets the margin size.
par(mfrow = c(2,2), mar = c(4,4,2,1))

## create the 4 plots here.
with(plot4DF, {
      plot(DateTime,Global_active_power, type="l", 
                            ylab="Global Active Power", xlab="")

      plot(DateTime,Voltage, type="l", 
                            ylab="Voltage", xlab="datetime")


      plot(DateTime,Sub_metering_1, type="l", 
                            ylab="Energy Sub metering", xlab="", col="grey")
      lines(DateTime,Sub_metering_2, col="red")
      lines(DateTime,Sub_metering_3, col="blue")
      legend("topright", lty=c(1,1), lwd=c(2.5, 2.5, 2.5) , 
                    col = c("grey", "red", "blue"), 
                    legend = c("Sub_metering_1","Sub_metering_3", "Sub_metering_3"))

      plot(DateTime,Global_reactive_power, type="l", 
                            ylab="Global_reactive_power", xlab="datetime")
})

## Close the PNG graphics device.
dev.off()

## Little bit of housekeeping here.
## This will remove the variables created by this program from the environment.
remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot4DF)

## Unload data.table package
detach("package:data.table", unload=TRUE)