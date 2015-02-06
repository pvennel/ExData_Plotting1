## Date  Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3


require(data.table)

powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% c("1/2/2007", "2/2/2007"), ]

powerConsumptionDFFilter <- subset(powerConsumptionDFFilter, Global_active_power != "?", select = c(1,2,3))

plot2DF <- as.data.frame(powerConsumptionDFFilter)

plot2DF$Global_active_power <- as.numeric(plot2DF$Global_active_power)

plot2DF$DateTime <- strptime(paste(plot2DF$Date,plot2DF$Time), "%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480, bg="white")

plot(plot2DF$DateTime,plot2DF$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()

remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot2DF)