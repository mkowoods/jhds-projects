
source("loadData.R")

plot4 <- function(pathToData){
    

    epcData <- loadData(pathToData)
    
    png("plot4.png")
    par(mfrow = c(2,2))
    
    plot(epcData$Date_Time, epcData$Global_active_power, 
         type="l",
         xlab= "", 
         ylab="Global Active Power")
    
    plot(epcData$Date_Time, epcData$Voltage, 
         type="l",
         xlab= "datetime", 
         ylab="Voltage")
    
    plot(epcData$Date_Time, epcData$Sub_metering_1, type = "l", col = "black", xlab ="", ylab = "Energy sub metering")
    lines(epcData$Date_Time, epcData$Sub_metering_2, type = "l", col = "red")
    lines(epcData$Date_Time, epcData$Sub_metering_3, type = "l", col = "blue")
    
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = c("solid", "solid", "solid"), 
           col=c("black","red", "blue"),
           bty = "n"
        )
    
    plot(epcData$Date_Time, epcData$Global_reactive_power, 
         type="l",
         xlab= "datetime", 
         ylab="Global_reactive_power")
    
    tmp <- dev.off()
    print("Image Written to plot4.png")
    par(mfrow = c(1,1))
}