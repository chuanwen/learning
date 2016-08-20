library(shiny)

shinyServer(function(input, output){
    a = readRDS("a.RDS")
    n = nrow(a)
    output$f2 <- renderTable({
        f1 <- strtoi(input$f1)
        val <- a[, f1]
        f2 <- order(val, decreasing=TRUE)
        data.frame(f2=f2, val=val[f2])
    }, include.rownames=FALSE)
})