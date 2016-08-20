library(shiny)

shinyServer(function(input, output, session) {
    output$latex1 <- renderUI({
        withMathJax(helpText(input$latex1))
    })
})