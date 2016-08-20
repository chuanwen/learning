library(shiny)

shinyServer(function(input, output){
    output$f2 <- renderTable({
        f1 <- which(letters %in% input$f1)
        val <- similarity[, f1]
        f2 <- order(val, decreasing=TRUE)
        data.frame(Feature1=letters[f1], Feature2=letters[f2], similarity=val[f2])
    }, include.rownames=FALSE, digits = 3)
})
