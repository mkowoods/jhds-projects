
#helper function for filtering and cleaning data for use in graphics
#my_path "C:\\Users\\Administrator\\Documents\\exdata-data-household_power_consumption\\household_power_consumption.txt"



loadData <- function(dataPath){
    as.numeric.factor <- function(x) {as.numeric(as.character(x))}
    print("Loading Data...")
    epcData <- read.table(dataPath,sep = ";", header = T)
    print("Filtering Data..")
    epcData <- epcData[grep("^[1|2]/2/2007", epcData$Date), ]
    print("Formatting Data..")
    
    epcData$Date <- as.Date(epcData$Date, format = "%d/%m/%Y")
    epcData$Time <- as.character(epcData$Time)
    epcData$Date_Time <- strptime(paste(epcData$Date, epcData$Time, sep = " "), "%Y-%m-%d %H:%M:%S")
    epcData$Global_active_power <- as.numeric.factor(epcData$Global_active_power)
    epcData$Global_reactive_power <- as.numeric.factor(epcData$Global_reactive_power)
    epcData$Voltage <- as.numeric.factor(epcData$Voltage)
    epcData$Global_intensity <- as.numeric.factor(epcData$Global_intensity)
    epcData$Sub_metering_1 <- as.numeric.factor(epcData$Sub_metering_1)
    epcData$Sub_metering_2 <- as.numeric.factor(epcData$Sub_metering_2) 
    epcData$Sub_metering_3 <- as.numeric.factor(epcData$Sub_metering_3)
    print("Data Set Completed...")
    return(epcData)    
}