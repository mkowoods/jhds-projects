
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
      tags$p("The App is based on the quakes dataset and explores the effect
             of using different values for the number of clusters on the 3 variables 
             lat, long and depth(which can be adjusted using the slider). The size is the Mean Magnitude per Cluster.
             What's interesting is to explore what level of information is retained as the number
             of points decreases.")
    )
  )
)