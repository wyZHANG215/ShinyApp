#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(dplyr)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # Compute the forumla text in a reactive expression since it is 
    # shared by the output$caption and output$mpgPlot expressions
    formulaText <- reactive({
        paste("mpg ~", case_when(input$variable == "cyl" ~ "Cylinders",  
                                input$variable == "am" ~ "Transmission", 
                                input$variable == "gear" ~ "Gears",
                                input$variable == "vs" ~ "Engine",
                                input$variable == "hp" ~ "Gross horsepower"
                                )
              )
    })
    
    formulaTextPlot <- reactive({
        paste("mpg ~", input$variable)
    })
    
    # Return the formula text for printing as a caption
    output$caption <- renderText({
        formulaText()
    })
    
    # Generate a plot of the requested variable against mpg and only 
    # include outliers if requested
    output$mpgPlot <- renderPlot({
        boxplot(as.formula(formulaTextPlot()), 
                data = mpgData,
                outline = TRUE)
    })

})
