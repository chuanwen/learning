library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Shiny Rank"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(selectInput("f1", "feature 1:", c(1:10), selected=1)),
        mainPanel(
            tableOutput("f2")
        )
    )
))