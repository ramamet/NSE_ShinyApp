## NIFTY options CALL/PUT analysis
##Introduction

nifty_ShinyApp is a fully featured promise Rstudio shiny app with focus on webscraping Call/Put options price and visualization. <br />
See the Code structure for further documentation, references and instructions.  <br />
Here is the screenshot of the App. <br />
![nse_app](https://cloud.githubusercontent.com/assets/16385390/15591736/111704f6-239f-11e6-89f9-be5cc9c9188d.png)

##Code structure

There are three stages to make a shiny app  <br />
#### 1. Web scraping of NSE options information  <br />
⋅⋅ First need to use **niftyoptions.R** for downloading options call/put price tag from www.nseindia.com and store it 
in options.csv and cmp.csv. <br />
#### 2. User interface design <br />
.. Shiny app design depends on CSS/HTML coding strength. Here we use **slide.css** of free design downloaded from http://bootswatch.com/  <br />
#### 3. Ploting design <br />
.. We have divided the screen into two sides , as left side of CALL opitons and right side of PUT options price information.

## Authors

Ramanathan Perumal (@ramamet) created nifty_ShinyApp and have contributed.

##License

Github Changelog Generator is released under the MIT License.
