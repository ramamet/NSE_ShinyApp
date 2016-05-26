library(shiny)
library(plotly)
library(shinythemes)

nifty=read.csv("cmp.csv")
date=format(Sys.Date(), "%d-%m-%Y")

shinyUI(fluidPage(
  #theme = shinytheme("flatly"),
  includeCSS("slate.css"),
  titlePanel(paste(nifty$cmp," @",date)),
 
  sliderInput("numR1", "LowStrike",
                min = 6500, max = 9000, value = 7200, step= 50,width="100%"),
   
   sliderInput("numR2", "HighStrike",
                min = 6500, max = 9000, value = 7800, step= 50,width="100%"), 

  mainPanel(
    splitLayout(cellWidths=c("80%","80%"),
    plotlyOutput("trend1Plot", width="90%",height="700px"),
    plotlyOutput("trend2Plot",width="90%",height="700px"))
  
  )
))
