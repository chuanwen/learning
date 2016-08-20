library(shiny)

shinyServer(function(input, output){
    output$distPlot <- renderPlot({
        x <- faithful[, 2]
        breaks <- seq(min(x), max(x), length.out=input$bins+1)
        # draw the histogram with the specified number of bins
        hist(x, breaks=breaks, col='darkgray', border='white')
    })
})
