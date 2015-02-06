

## Date  Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3

require(data.table)

powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

plot3DF <- as.data.frame(powerConsumptionDFFilter)

plot3DF <- subset(plot3DF, select = c(1,2,7,8,9))

plot3DF$DateTime <- strptime(paste(plot3DF$Date,plot3DF$Time), "%d/%m/%Y %H:%M:%S")

plot3DF$Sub_metering_1 <- as.numeric(plot3DF$Sub_metering_1)
plot3DF$Sub_metering_2 <- as.numeric(plot3DF$Sub_metering_2)
plot3DF$Sub_metering_3 <- as.numeric(plot3DF$Sub_metering_3)

png("plot3.png", width=480, height=480, bg="white")

plot(plot3DF$DateTime,plot3DF$Sub_metering_1, type="l", ylab="Energy Sub metering", xlab="", col="grey")
lines(plot3DF$DateTime,plot3DF$Sub_metering_2, col="red")
lines(plot3DF$DateTime,plot3DF$Sub_metering_3, col="blue")
legend("topright", lty=c(1,1), lwd=c(2.5, 2.5, 2.5) , 
       col = c("grey", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_3", "Sub_metering_3"))

dev.off()

remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot3DF)