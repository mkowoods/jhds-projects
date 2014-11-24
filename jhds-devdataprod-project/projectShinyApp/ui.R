
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Review Cluster of Quakes Data"),
    sidebarPanel(
      sliderInput(inputId = 'clusters', label = 'Choose the Number fo Clusters', min = 25, max = 925, value = 925, step = 100)
    ),
    mainPanel(
      plotOutput(outputId = 'plotDepth'),
      tags$h3("Description"),
      tags$p("The Purpose of this app is to explore how a geospatioal")
    )
  )
)