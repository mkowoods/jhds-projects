source("loadData.R")

plot3 <- function(pathToData){
    
    epcData <- loadData(pathToData)
    
    png("plot3.png")
    
    plot(epcData$Date_Time, epcData$Sub_metering_1, type = "l", col = "black", xlab ="", ylab = "Energy sub metering")
    lines(epcData$Date_Time, epcData$Sub_metering_2, type = "l", col = "red")
    lines(epcData$Date_Time, epcData$Sub_metering_3, type = "l", col = "blue")
    
    legend("topright", 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty = c("solid", "solid", "solid"),
           col=c("black","red", "blue")
           )
    

    tmp <- dev.off()
    print("Image Written to plot3.png")
}