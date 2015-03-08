## Reading the data into R Studio
the_data <- "C:\\Users\\Brad and Kathleen\\Documents\\Coursera\\EDA\\exdata-data-household_power_consumption\\household_power_consumption.txt"
data <- read.table(the_data, header = TRUE, sep = ";", na.string = "?", 
                   col.names = c("Date", "Time", 
                                 "Global_Active_Power", "Global_Reactive_Power", "Voltage", 
                                 "Global_Intensity", "Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"))

## Formatting Dates and Times in the file.
as.Date(data$Date, format = "%d-%m-%Y")
strptime(data$Time, format = "H%:M%:S%")


## Creating a data frame of the data.
Master <- data.frame(data)

## Extracting the two dates and creating a data set for each. 
## Then use rbind() to combine the two sets of data. 
Master1 <- Master[Master$Date == "1/2/2007", ]
Master2 <- Master[Master$Date == "2/2/2007", ]
Master3 <- rbind(Master1, Master2)    ##Data set of both dates combined.


Master3$DateTime <- strptime(paste(Master3$Date, Master3$Time, sep=" "), 
                             format="%d/%m/%Y %H:%M:%S")

png("plot3.png", width = 480, height = 480)

plot(Master3$DateTime, Master3$Sub_Metering_1, type = "l", xlab = "", 
     ylab = "Energy Sub Metering", col = "black") 
lines(Master3$DateTime, Master3$Sub_Metering_2, col = "red")
lines(Master3$DateTime, Master3$Sub_Metering_3, col = "blue")

legend("topright", col = c("black", "red", "blue"), c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"),
      lty = 1, lwd = 2.5)

dev.off()