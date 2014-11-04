#Plot3    


#Script Requires ggplot2 and sqldf

library(ggplot2)
library(sqldf)


NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#NEI <- subset(NEI, NEI == "24510")

pm25.Emissions.by.year.type <- sqldf(
                                        "select 
                                            year,
                                            type,
                                            sum(Emissions) Emissions,
                                            count(*) rec_ct
                                        from NEI
                                        where
                                            fips = '24510'
                                        group by
                                            year,
                                            type"
                                        )




png("plot3.png", width = 720, height = 480)

qplot(factor(year), Emissions, data = pm25.Emissions.by.year.type, 
      geom = "bar", 
      stat = "identity", 
      facets = .~ type, 
      fill = type,
      xlab = "Year",
      ylab = expression('PM'[2.5]*' Emissions, tons'),
      main = expression('PM'[2.5]*' Emissions by Year and Type for 1999 - 2008')
      )


tmp <- dev.off()