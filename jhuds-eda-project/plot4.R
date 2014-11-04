#Plot4 


#Script Requires ggplot2,scales and sqldf

library(ggplot2)
library(sqldf)
library(scales)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Pulled all EI.Sector Codes that contain the term coal
SCC.Coal.Codes <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case = TRUE)]
NEI.Coal <- subset(NEI, SCC %in% SCC.Coal.Codes)


pm25.Coal.Emissions.by.year <- sqldf(
                                        "select 
                                            year,
                                            sum(Emissions) Emissions
                                        from [NEI.Coal]
                                        where 1=1
                                        group by
                                            year
                                        "
                                    )




png("plot4.png", width = 480, height = 480)

qplot(factor(year), Emissions, data = pm25.Coal.Emissions.by.year,
      fill = I("#E69F00"),
      geom = "bar", 
      stat = "identity",
      xlab = "Year",
      ylab = expression('PM'[2.5]*' Emissions, tons'),
      main = expression('PM'[2.5]*' Emissions by Year from Coal for 1999 - 2008')
) + scale_y_continuous(labels = comma) + guides(fill = FALSE)

tmp <- dev.off()
