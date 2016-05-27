#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Author: Ramanathan Perumal
# mail  : ramamet3@gmail.com
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

# Load supported libraries 
library(shiny)
library(ggplot2)
library(readr)
library(dplyr)
library(RColorBrewer)


sub=read_csv("options.csv")
sub=sub[,-1]

Df=sub

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("NSE India")
    })

  # Return the formula text for printing as a caption
  output$caption <- reactiveText(function(){
    formulaText()
  })

  
  output$trend1Plot <- renderPlotly({
  
  expDate="30JUN2016" 
  date=format(Sys.Date(), "%d-%m-%Y")
  nr= nrow(Df)
  nr=nr*0.025
  nr=4.8-nr
  
  minP =input$numR1
  maxP =input$numR2
  
  Df$strikeprice= as.numeric(as.character(Df$strikeprice))
  Df=filter(Df,strikeprice>minP & strikeprice<maxP)
  
  Df$strikeprice= as.factor(as.character(Df$strikeprice))

 Max=(max(Df$call.OI))+200000

#avoid scientific notations in ploting
 
#gg1=ggplot(Df,aes(x=strikeprice,y=call.OI),label=Df$call.ltp)+
gg1=ggplot(Df,aes(x=strikeprice,y=call.OI))+
   geom_bar(stat="identity",alpha=0.70,fill="#009E73",width=0.1)+ 
  coord_flip()+
  geom_text(data=NULL,label=Df$call, hjust=2.6, vjust=-1,size=nr,color="white")+
   theme_bw()+
  ylim(-75000,Max) +
  xlab("")+ylab("")+
  ggtitle("CALL")+
 
   theme(
     panel.grid.minor = element_blank(),
     panel.grid.major = element_blank(),
     panel.background = element_rect(fill = "grey30")
   )
   

    s1 <- ggplotly(gg1)
    s1
    
  })
  
  #++++++++++++++++++++++
  
 output$trend2Plot <- renderPlotly({
  
  expDate="26MAY2016" 
  date=format(Sys.Date(), "%d-%m-%Y")
  nr= nrow(Df)
  nr=nr*0.025
  nr=4.8-nr
     
 #Min=-((max(Df$put.OI))+10000)
 Max=(max(Df$call.OI))+200000
 
  minP =input$numR1
  maxP =input$numR2
  
  Df$strikeprice= as.numeric(as.character(Df$strikeprice))
  Df=filter(Df,strikeprice>minP & strikeprice<maxP)
  
  Df$strikeprice= as.factor(as.character(Df$strikeprice))
 

#gg2=ggplot(Df,aes(x=strikeprice,y=put.OI),label=Df$put.ltp)+
gg2=ggplot(Df,aes(x=strikeprice,y=put.OI))+
 # geom_bar(data=Df,aes(x=strikeprice,y=(put.OI)),stat="identity",color="darkred",alpha=0.1,fill="#CC79A7",width=0.3)+
   geom_bar(stat="identity",alpha=0.70,fill="#CC79A7",width=0.1)+ 
  #  geom_bar(stat="identity",color="darkred",alpha=0.4,fill="darkred",width=0.3)+ 
  coord_flip()+
  geom_text(data=NULL,label=Df$put, hjust=2.6, vjust=0.5,size=nr,color="white")+
  theme_bw()+
  ylim(-75000, Max)+
  xlab("")+ylab("")+
  ggtitle("PUT")+
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank(),
    panel.background = element_rect(fill = "grey30")
    )

 
    s2 <- ggplotly(gg2)
    s2
  })
  
  
   
 
  
})
