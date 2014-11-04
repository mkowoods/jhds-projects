

#Plot2    

NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

NEI <- subset(NEI, NEI == "24510")

pm25Emissions.by.year <- tapply(NEI$Emissions, factor(NEI$year), sum)

png("plot2.png", width = 480, height = 480)

barplot(pm25Emissions.by.year,
        main = expression('PM'[2.5]*' Emissions, Baltimore City'),
        #axes = FALSE,
        xlab = "Years",
        ylab = expression('PM'[2.5]*', tons')
)


tmp <- dev.off()