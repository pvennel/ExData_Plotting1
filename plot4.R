## Date  Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3

require(data.table)

powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

plot4DF <- as.data.frame(powerConsumptionDFFilter)

plot4DF$Global_active_power <- as.numeric(plot4DF$Global_active_power)

plot4DF$lobal_reactive_power <- as.numeric(plot4DF$lobal_reactive_power)

plot4DF$Voltage <- as.numeric(plot4DF$Voltage)

plot4DF$Sub_metering_1 <- as.numeric(plot4DF$Sub_metering_1)

plot4DF$Sub_metering_2 <- as.numeric(plot4DF$Sub_metering_2)

plot4DF$DateTime <- strptime(paste(plot4DF$Date,plot4DF$Time), "%d/%m/%Y %H:%M:%S")


png("plot4.png", width=480, height=480, bg="white")

par(mfrow = c(2,2), mar = c(4,4,2,1))

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

dev.off()

remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot4DF)
