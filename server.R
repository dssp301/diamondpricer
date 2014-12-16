library(shiny)

# load the diamonds dataset
require(ggplot2)
data(diamonds)
# use log of the diamond prices as this enables a linear fit
diamonds$logprice <- log(diamonds$price)

# build the model using carat, cut, color and clarity as predictors.
# Also use the cube root of carat as a predictor because the weight of 
#a diamond is a function of volume and volume is a function of x, y, z dimensions.
model <- lm(logprice ~  I(carat^(1/3)) + carat + cut + color + clarity, data=diamonds)

# define the Shiny server
shinyServer(function(input, output) {
        output$price <- renderText({
                # Create a new diamond based on the received input
                newDiamond <- data.frame(carat = input$carat, cut = input$cut,
                                       color = input$color, clarity = input$clarity)
                # Run the predictor expecting a 95% confidence level
                estimate <- predict(model, newdata = newDiamond, interval='prediction',
                                   level = .95)
                # Compute the true price by reversing the 'log' function applied to the price earlier.
                price <- paste0(as.character(format(round(exp(estimate) * exp(summary(model)$sigma^2/2), 0)[1], digits = 2)), ".00")
                return(price)
        })
})
