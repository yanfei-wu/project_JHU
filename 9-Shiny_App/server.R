library(shiny)
library(ggplot2)
url <- "http://files.zillowstatic.com/research/public/State/State_Zhvi_AllHomes.csv"
download.file(url, destfile = "homevalue.csv")
h <- t(read.csv("homevalue.csv", header = F, stringsAsFactors = F))
h2 <- h[-c(1:3), c(1,2)]
library(zoo)
h2[,1] <- as.yearmon(h2[,1], "%Y-%m")
h2[,2] <- (as.numeric(h2[,2]))/1000

shinyServer(
    function(input, output){
        output$newplot <- renderPlot({
            plot(h2[,1], h2[,2], type = "l", col = "red", 
                 xlab = "Time", ylab = "Price (1000 USD)",
                 xlim = c(as.yearmon(input$dates)[1], 
                          as.yearmon(input$dates)[2]),
                 main = "Median Home Value in CA")
            myTicks = axTicks(2)
            axis(2, at = myTicks, 
                 labels = formatC(myTicks, format = 'd'))
        })
        
        output$inputValue <- renderPrint({
            paste("Median Home Value between", input$dates[1], 
                  "and", input$dates[2], "based on Zillow Home Value Index")
            })
    }
)

