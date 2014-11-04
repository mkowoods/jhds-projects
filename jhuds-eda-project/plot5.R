#Plot 5


#Script Requires ggplot2,scales and sqldf

library(ggplot2)
library(sqldf)
library(scales)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Pulled all EI.Sector Codes that contain the term coal
SCC.MV.Codes <- SCC$SCC[grep("Mobile - On-Road", SCC$EI.Sector)]
NEI.MV <- subset(NEI, SCC %in% SCC.MV.Codes)


pm25.MV.Emissions.by.year <- sqldf(
    "select 
    year,
    sum(Emissions) Emissions
    from [NEI.MV]
    where
     fips = '24510'
    group by
    year
    "
)




png("plot5.png", width = 480, height = 480)

qplot(factor(year), Emissions, data = pm25.MV.Emissions.by.year,
      fill = I("#56B4E9"),
      geom = "bar", 
      stat = "identity",
      xlab = "Year",
      ylab = expression('PM'[2.5]*' Emissions, tons'),
      main = expression('PM'[2.5]*' Emissions by Year from Motor Vehicles in Baltimore City')
) + scale_y_continuous(labels = comma) + guides(fill = FALSE)

tmp <- dev.off()
