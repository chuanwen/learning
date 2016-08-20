library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Hello Shiny!"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(sliderInput("bins", "Num of bins:", 
                                 min=1, max=50, value=30)),
        mainPanel(plotOutput("distPlot"))
    )
))
