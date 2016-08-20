library(shiny)

shinyUI(fluidPage(
    # Application title
    titlePanel("Shiny Rank"),

    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(selectInput("f1", "feature 1:", letters[c(1:10)], selected="a")),
        mainPanel(
            h3("Ordered similarity of feature 1 with other features"),
            tableOutput("f2")
        )
    )
))
