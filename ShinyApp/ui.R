## ui.R for Shiny App
library(shiny)
library(ggplot2)

dataset <- mtcars

fluidPage(
    
    titlePanel("Car Analysis"),
    
    sidebarPanel(
        actionButton("do", "Click to see program help"),
        # h3('Description of program:'), 
        textOutput('helptext'),
        selectInput('x', 'X', names(dataset), names(dataset)[[6]]),
        selectInput('y', 'Y', names(dataset), names(dataset)[[1]]),
        selectInput('color', 'Color', c('None', names(dataset))),
        
        checkboxInput('boxplot', 'Boxplot'),
        checkboxInput('smooth', 'Smooth'),
        
        # numericInput('dot_size','Size of points on graph ', 1, min = 1, max = 40, step=5),
        
        selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
        selectInput('facet_col', 'Facet Column', c(None='.', names(dataset)))
    ),
    
    mainPanel(
       
        h3("R^2 of regression model:"),
        verbatimTextOutput(outputId= "lmR2"),
        plotOutput('plot')
    
    )
)