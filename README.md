## NIFTY options CALL/PUT analysis
--
##Introduction

nifty_ShinyApp is a fully featured promise Rstudio shiny app with focus on webscraping Call/Put options price and visualization

See the Code structure for further documentation, references and instructions. See the screenshot of the App here.

--
##Code structure

There are three stages to make a shiny app  <br />
1. Web scraping of NSE options information  <br />
⋅⋅ Here we need to use **niftyoptions.R** for downloading options call/put price tag from www.nseindia.com and store it 
in options.csv and cmp.csv. <br />
2. User interface definition <br />
