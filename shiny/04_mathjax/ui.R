library(shiny)

shinyUI(fluidPage(
    titlePanel("MathJax Demo"),
    textInput("latex1", "LaTex formula:", placeholder="$$x+y$$"),
    uiOutput('latex1')
))