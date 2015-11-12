# server.R for ShinyApp
library(shiny)
library(ggplot2)

function(input, output, session) {
    output$helptext <- renderText({
        if (input$do != 0)
        ' Program description:  An analysis of the mtcars dataset.
 Select your predictor (X) and your outcome
(Y). You may choose to look at the data by category (Facet Row and/or 
Facet Column) if you want.  Boxplot options and smooth option are also
        available. The R^2 value provided is for the lm(Y~X) or 
        Y = b0 + b1X.'
    })
    dataset <-  mtcars
    output$plot <- renderPlot({
        
        p <- ggplot(dataset, aes_string(x=input$x,y=input$y))  
        if (input$boxplot != 1)
            p <- p + geom_point()
       
        
        if (input$color != 'None')
            p <- p + aes_string(color=input$color)
        
        facets <- paste(input$facet_row, '~', input$facet_col)
        if (facets != '. ~ .')
            p <- p + facet_grid(facets)
        
        if (input$boxplot)
            p <- p + geom_boxplot()
        if (input$smooth)
            p <- p + geom_smooth()
           
        print(p)
        
    }, height=700)
       output$lmR2 <- renderPrint({
            yvsx <- paste(input$y,'~',input$x)
            summary(lm(yvsx, dataset))$r.squared
        })
}