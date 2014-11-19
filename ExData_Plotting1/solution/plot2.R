#Provide path to Data "<your directory>\\household_power_consumption.txt"
#as an input to the function and the image will be saved in the current working
#directory


plot2 <- function(pathToData){
    
    epcData <- loadData(pathToData)
    
    png("plot2.png")
    
    plot(epcData$Date_Time, epcData$Global_active_power, 
            type="l",
            xlab= "", 
            ylab="Global Active Power (kilowatts)")
    tmp <- dev.off()
    print("Image Written to plot2.png")
}