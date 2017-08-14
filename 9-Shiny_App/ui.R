library(shiny)
shinyUI(pageWithSidebar(
    ## Application title
    headerPanel("Home Value in California"),
    
    sidebarPanel(
        ## Select year and month
        dateRangeInput("dates", 
                       start = "1996-04",
                       end = "2016-05",
                       min = "1996-04",
                       max = "2016-05",
                       label = h3("Select Date Range"), 
                       startview = "decade")
    ),
    
    mainPanel(
        plotOutput("newplot"),
        verbatimTextOutput("inputValue")
    )
))