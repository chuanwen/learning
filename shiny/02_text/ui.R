library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Shiny Text"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(textInput("caption", "Caption:", "Data Summary"),
                     selectInput("dataset", "Choose a dataset:", 
                                 choices=c("rock", "pressure", "cars")),
                     numericInput("obs", "number of observations to view:", 10)),
        mainPanel(
            h3(textOutput("caption", container = span)),
            verbatimTextOutput("summary"),
            tableOutput("view")
        )
    )
))
