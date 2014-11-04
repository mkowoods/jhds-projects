#Code for Running plot1.R

NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25Emissions.by.year <- tapply(NEI$Emissions, factor(NEI$year), sum)

maxMM <- floor(max(pm25Emissions.by.year)/1000000) + 1

ticks = (0:maxMM)*1000000

png("plot1.png", width = 480, height = 480)

barplot(pm25Emissions.by.year,
        main = expression('PM'[2.5]*' Emissions'),
        axes = FALSE,
        xlab = "Years",
        ylab = expression("PM"[2.5]*", tons")
)


axis(2, at = ticks, labels = paste(0:8, "MM", sep = ""))

tmp <- dev.off()
