#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Miles Per Gallon (MPG)"),

    # Sidebar with a slider input for number of bins
    sidebarPanel(
        h4("This app uses the Motor Trend Car Road Tests data. It will show a boxplot of mpg based on the input variable selected."),
        
        selectInput("variable", "Variable:",
                    list("Cylinders" = "cyl", 
                         "Transmission" = "am", 
                         "Gears" = "gear",
                         "Engine" = "vs",
                         "Gross horsepower" = "hp"))
        
        
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3(textOutput("caption")),
            plotOutput("mpgPlot")
        )
    )
)
