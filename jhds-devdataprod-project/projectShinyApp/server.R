library(ggplot2)
data(quakes)
set.seed(42)

#Done to scale the Quake lat, longitude and depth coords
quakes.scale <- scale(quakes[, 1:3])
lat.scale <- attr(quakes.scale, "scaled:scale")["lat"]
long.scale <- attr(quakes.scale, "scaled:scale")["long"]
depth.scale <- attr(quakes.scale, "scaled:scale")["depth"]
lat.center <- attr(quakes.scale, "scaled:center")["lat"]
long.center <- attr(quakes.scale, "scaled:center")["long"]
depth.center <- attr(quakes.scale, "scaled:center")["depth"]


shinyServer(
  function(input, output) {
    
    output$plotDepth <- renderPlot({
      clustered.data <- kmeans(quakes.scale, input$clusters)
      centers <- as.data.frame(clustered.data$centers)
      centers$lat <- centers$lat * lat.scale + lat.center
      centers$long <- centers$long * long.scale + long.center
      centers$depth <- centers$depth * depth.scale + depth.center
      centers$mean.mag <- tapply(X = quakes$mag, INDEX = clustered.data$cluster, mean)
      g <- ggplot(centers, aes(long, lat), na.rm = TRUE)
      g <- g + geom_point(colour = "black")
      g <- g +  geom_point(aes(size = mean.mag, color = depth), alpha = 1/2)
      g <- g + scale_x_continuous("Longitude", limits = c(160, 195)) 
      g <- g + scale_y_continuous("Latitude", limits = c(-45, -5))
      g <- g + scale_size("Mean\nMagnitude", limits = c(3.5, 6)) 
      g + scale_color_gradient("Depth", high = "#132B43", low = "#56B1F7", limits = c(20, 720))
    })
    output$var.prediction <- renderPrint({
      clustered.data <- kmeans(quakes.scale, input$clusters)
      centers <- as.data.frame(clustered.data$centers)
      centers$lat <- centers$lat * lat.scale + lat.center
      centers$long <- centers$long * long.scale + long.center
      centers$depth <- centers$depth * depth.scale + depth.center
      centers$mean.mag <- tapply(X = quakes$mag, INDEX = clustered.data$cluster, mean)
      var(centers$mean.mag)
      })
  }
)