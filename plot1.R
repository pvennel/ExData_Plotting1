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
plot1DF <- as.data.frame(powerConsumptionDFFilter)

## subsetting to filter to required columns Date, Time and Global_active_Power
## Also removing row where Global_active_power contains "?"
plot1DF <- subset(powerConsumptionDFFilter, Global_active_power != "?", select = c(1,2,3))

## converting the character column to numeric
plot1DF$Global_active_power <- as.numeric(plot1DF$Global_active_power)

## create a plot.
## Initialize the png file device.
png("plot1.png", width=480, height=480, bg="white")

## create the histogram
## mar sets the margin size.
hist(plot1DF$Global_active_power, col="red", 
        main="Global Active Power",
        xlab="Global Active Power (kilowatts)",
        mar = c(3,4,2,1))

## Close the PNG graphics device.
dev.off()

## Little bit of housekeeping here.
## This will remove the variables created by this program from the environment.
remove(powerConsumptionDT)
remove(powerConsumptionDFFilter)
remove(plot1DF)

## Unload data.table package
detach("package:data.table", unload=TRUE)
