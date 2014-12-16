library(shiny)

# load the diamonds dataset.  This will be used to create our selection lists later.
require(ggplot2)
data(diamonds)

# Define UI for the Diamond Pricer!
shinyUI(navbarPage("Diamond Pricer!",
        # Create the tabs
        tabPanel("Instructions",
                mainPanel(
                        p("Diamond Pricer! will assist a diamond merchant quickly evaluate the value of a diamond based on Carats (weight), Cut, Color and Clarity.",
                        "These are the 4C's that are typically used to evaluate diamonds.  Below is a Quick Start guide for this app and the 'About' tab gives additional information about this app."),
                        p(""),
                        p(""),
                        h4("Quick start:"),
                        p("1) Select the 'Evaluate Diamond' tab above."),
                        p("2) Use the slidebar to select the weight of the diamond in Carats."),
                        p("3) Select the Cut of the diamond."),
                        p("4) Select the Color of the diamond.  Note: 'D' is the best and 'J' is the worst."),
                        p("5) Select the Clarity of the Diamond. Note: 'I1' is the worst and 'IF' is the best."),
                        p("6) The main panel will display the 'Expected Price' of your diamond."),
                        p(" "),
                        p(" "),
                        p(" "),
                        h6("For additional reference information see the ", a(href="http://www.pricescope.com/wiki/diamonds/", "Diamond Guide"))
                )
        ), 
        tabPanel("Evaluate Diamond",
                # Sidebar with a slider input for number of observations
                sidebarPanel(
                        sliderInput("carat", 
                                    "Weight of diamond (carats)", 
                                    min = .01,
                                    max = 5, 
                                    value = 0.5,
                                    step = 0.01),
                        selectInput("cut", "Cut of diamond", 
                                    # extracts the choices from the dataset
                                    choices = levels(diamonds$cut)),
                        selectInput("color", "Color of diamond", 
                                    # extracts the choices from the dataset
                                    choices = levels(diamonds$color)),
                        selectInput("clarity", "Clarity of diamond", 
                                    # extracts the choices from the dataset
                                    choices = levels(diamonds$clarity)),
                        helpText("Diamonds are Forever!")
                ),
                # Show the computed price.
                mainPanel(
                        h3("Expected price:"),
                        h4("$", textOutput("price", inline = TRUE))
                )
                
        ),
        tabPanel("About",
                 mainPanel(
                        p("Diamond Pricer! was created using Shiny, a web application framework for R developed and suported by RStudio."),
                        p("This app leverages the 'diamonds' dataset delivered as part of the ggplot2 R package.  Using this dataset",
                        "we have developed a diamond price predictor given 4 input criteria (Carats, Cut, Color and Clarity) of a diamond."),
                        p("The 'Shiny' source code for this app is available", a(href="http://dssp301.github.com/diamondpricer", "here.")),
                        p(""),
                        h6(" - This tool was developed by SP"),
                        h6(" - version 1.00"),
                        p(""),
                        p(""),
                        h3("Diamonds are Forever!")
                 )
        ) 
))


