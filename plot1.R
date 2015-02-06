
## Date  Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3


require(data.table)

powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

plot1DF <- as.data.frame(powerConsumptionDFFilter)

plot1DF <- subset(powerConsumptionDFFilter, Global_active_power != "?", select = c(1,2,3))

plot1DF$Global_active_power <- as.numeric(plot1DF$Global_active_power)

png("plot1.png", width=480, height=480, bg="white")

hist(plot1DF$Global_active_power, col="red", 
        main="Global Active Power",
        xlab="Global Active Power (kilowatts)",
        mar = c(3,4,2,1))

dev.off()

remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot1DF)


