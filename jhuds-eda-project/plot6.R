#Plot 6


#Script Requires ggplot2,scales and sqldf

library(ggplot2)
library(grid)
library(sqldf)
library(scales)


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Pulled all EI.Sector Codes that contain the term "Mobile - On-Road"
SCC.MV.Codes <- SCC$SCC[grep("Mobile - On-Road", SCC$EI.Sector)]
NEI.MV <- subset(NEI, SCC %in% SCC.MV.Codes)


pm25.MV.Emissions.by.year <- sqldf(
    "select 
        year,
        fips,
        --sum(case when fips == '06037' then Emissions else 0 end) Emissions_06037,
        --sum(case when fips == '24510' then Emissions else 0 end) Emissions_24510
        sum(Emissions) Emissions    
    from [NEI.MV]
    where
        fips in ('24510', '06037')
    group by
        year,
        fips
    order by
        year,
        fips desc        
    "
)

pm25.MV.Emissions.by.year$cities = ifelse(pm25.MV.Emissions.by.year$fips == "06037", "Los Angeles", "Baltimore")

emission.1999.data <- pm25.MV.Emissions.by.year[(pm25.MV.Emissions.by.year$year == 1999), ]
emission.2008.data <- pm25.MV.Emissions.by.year[(pm25.MV.Emissions.by.year$year == 2008), ]

change.in.emissions <- emission.2008.data$Emissions - emission.1999.data$Emissions

change.from.1999.to.2008 <- data.frame(cities = emission.1999.data$cities, 
                                       change.in.emissions)



png("plot6.png", width = 1080, height = 720)

pushViewport(viewport(layout = grid.layout(2, 2, heights = unit(c(1, 9), "null"))))
grid.text(expression(bold('Change in PM'[2.5]*' Emissions by Year from Motor Vehicles in Baltimore and LA')),
          vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))

p1 <- qplot(factor(year), Emissions, data = pm25.MV.Emissions.by.year,
      facets = .~ cities, 
      fill = cities,
      geom = "bar", 
      stat = "identity",
      xlab = "",
      ylab = expression('PM'[2.5]*' Emissions, tons')
      #main = expression('PM'[2.5]*' Emissions by Year from Motor Vehicles in Baltimore City')
) + scale_y_continuous(labels = comma) + guides(fill = FALSE)


p2 <- qplot(cities, change.in.emissions, data = change.from.1999.to.2008,
            fill = cities,
            geom = "bar", 
            stat = "identity",
            xlab = "",
            #ylim = c(-200, 200),
            width = .25,
            ylab = expression('Net change in PM'[2.5]*' Emissions(tons ) 1999 - 2008')
            #main = expression('Change in PM'[2.5]*' Emissions by Year from Motor Vehicles in Baltimore and LA')
) 
p2 <- p2 + geom_abline(intercept = 0, slope = 0)
p2 <- p2 + scale_y_continuous(limits = c(-300, 300), labels = comma) + guides(fill = FALSE) + coord_flip() + theme_bw()


print(p1, vp = viewport(layout.pos.row = 2, layout.pos.col = 1))
print(p2, vp = viewport(layout.pos.row = 2, layout.pos.col = 2))

tmp <- dev.off()
