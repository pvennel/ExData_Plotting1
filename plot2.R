## load package data.table
require(data.table)

## read the data file using fread for speed
powerConsumptionDT <- fread("household_power_consumption.txt", sep=";")

## we only need data for 2 days. So extracting only the required data.
powerConsumptionDFFilter <- powerConsumptionDT[powerConsumptionDT$Date %in% 
                                                 c("1/2/2007", "2/2/2007"), ]

## subsetting to filter to required columns Date, Time and Global_active_Power
## Also removing row where Global_active_power contains "?"
powerConsumptionDFFilter <- subset(powerConsumptionDFFilter, Global_active_power != "?", 
                                        select = c(1,2,3))

## converting from data.table to data .frame
plot2DF <- as.data.frame(powerConsumptionDFFilter)

## converting the character column to numeric
plot2DF$Global_active_power <- as.numeric(plot2DF$Global_active_power)

## create a new column combining Date and Time and then converting it to POSIXlt
plot2DF$DateTime <- strptime(paste(plot2DF$Date,plot2DF$Time), "%d/%m/%Y %H:%M:%S")

## create a plot.
## Initialize the png file device.
png("plot2.png", width=480, height=480, bg="white")

## create the plot here
plot(plot2DF$DateTime,plot2DF$Global_active_power, type="l", 
                            ylab="Global Active Power (kilowatts)", 
                            xlab="")

## Close the PNG graphics device.
dev.off()

## Little bit of housekeeping here.
## This will remove the variables created by this program from the environment.
remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot2DF)

## Unload data.table package
detach("package:data.table", unload=TRUE)