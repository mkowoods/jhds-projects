
#Provide path to Data "<your directory>\\household_power_consumption.txt"
#as an input to the function and the image will be saved in the current working
#directory

source("loadData.R")

plot1 <- function(pathToData){
    epcData <- loadData(pathToData)
    
    png("plot1.png")
    
    hist(epcData$Global_active_power, 
        main = "Global Active Power", 
        xlab = "Global Active Power (kilowatts)",
        col = "red"
        )
    tmp <- dev.off()
    print("Image Written to plot1.png")
}