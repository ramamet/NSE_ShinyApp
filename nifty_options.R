#*************************************************************************************************

#*** Extract current month NIFTY (CALL and PUT) options prices from www.nseindia,con 
# Author: Ramanathan Perumal
# mail: ramamet3@gmail.com

#**************************************************************************************************

library(dplyr)
library(ggplot2)
library(RColorBrewer)

require(RSelenium)
RSelenium::startServer()
Sys.sleep(5)
remDr <- remoteDriver(browserName = "phantomjs")

remDr$open()

name="NIFTY"    
expDate="30JUN2016" # June Contract
  

 URL=paste0("http://www.nseindia.com/live_market/dynaContent/live_watch/option_chain/optionKeys.jsp?",
            "segmentLink=17",
            "&instrument=OPTIDX",
            "&symbol=",name,
            "&date=",expDate,
             sep="")


remDr$navigate(URL)    

# #company
 cmpText <- remDr$findElements(using="xpath", '//span//b')
 cmp <- unlist(lapply(cmpText, function(x) x$getElementText()))
 cmp =data.frame(cmp)
 

strikepriceText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 12) and parent::*)]')
strikeprice <- unlist(lapply(strikepriceText, function(x) x$getElementText()))
strikeprice <- gsub(",","",strikeprice)
strikeprice=data.frame(strikeprice)

openinterestText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 2) and parent::*)]')
openinterest<- unlist(lapply(openinterestText, function(x) x$getElementText()))
openinterest<- gsub(",","",openinterest)
openinterest=data.frame(openinterest)
openinterest=openinterest[-(1:3),]
openinterest=data.frame(openinterest)
nr=nrow(openinterest)
openinterest=openinterest[-(nr),]
openinterest=data.frame(openinterest)
call.openinterest=openinterest

changeOIText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 3) and parent::*)]')
changeOI <- unlist(lapply(changeOIText, function(x) x$getElementText()))
changeOI <- gsub(",","",changeOI)
changeOI=data.frame(changeOI)
changeOI=changeOI[-1,]
changeOI=data.frame(changeOI)
nr=nrow(changeOI)
changeOI=changeOI[-(nr),]
changeOI=data.frame(changeOI)
call.changeOI=changeOI

ltpText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 6) and parent::*)]')
ltp <- unlist(lapply(ltpText, function(x) x$getElementText()))
ltp <- gsub(",","",ltp)
ltp=data.frame(ltp)
call.ltp=ltp

netchangeText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 7) and parent::*)]')
netchange <- unlist(lapply(netchangeText, function(x) x$getElementText()))
netchange <- gsub(",","",netchange)
netchange=data.frame(netchange)
call.netchange=netchange

bidpriceText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 9) and parent::*)]')
bidprice <- unlist(lapply(bidpriceText, function(x) x$getElementText()))
bidprice <- gsub(",","",bidprice)
bidprice=data.frame(bidprice)
call.bidprice=bidprice

askpriceText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 10) and parent::*)]')
askprice <- unlist(lapply(askpriceText, function(x) x$getElementText()))
askprice <- gsub(",","",askprice)
askprice=data.frame(askprice)
call.askprice=askprice


#**************************************

openinterestText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 22) and parent::*)]')
openinterest<- unlist(lapply(openinterestText, function(x) x$getElementText()))
openinterest<- gsub(",","",openinterest)
openinterest=data.frame(openinterest)
put.openinterest=openinterest

changeOIText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 21) and parent::*)]')
changeOI <- unlist(lapply(changeOIText, function(x) x$getElementText()))
changeOI <- gsub(",","",changeOI)
changeOI=data.frame(changeOI)
put.changeOI=changeOI

ltpText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 18) and parent::*)]')
ltp <- unlist(lapply(ltpText, function(x) x$getElementText()))
ltp <- gsub(",","",ltp)
ltp=data.frame(ltp)
put.ltp=ltp

netchangeText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 17) and parent::*)]')
netchange <- unlist(lapply(netchangeText, function(x) x$getElementText()))
netchange <- gsub(",","",netchange)
netchange=data.frame(netchange)
put.netchange=netchange

bidpriceText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 14) and parent::*)]')
bidprice <- unlist(lapply(bidpriceText, function(x) x$getElementText()))
bidprice <- gsub(",","",bidprice)
bidprice=data.frame(bidprice)
put.bidprice=bidprice

askpriceText <- remDr$findElements(using="xpath",'//tr//*[(((count(preceding-sibling::*) + 1) = 15) and parent::*)]')
askprice <- unlist(lapply(askpriceText, function(x) x$getElementText()))
askprice <- gsub(",","",askprice)
askprice=data.frame(askprice)
put.askprice=askprice

df=cbind(strikeprice,call.ltp,call.openinterest,put.ltp,put.openinterest,call.netchange,put.netchange)
colnames(df)=c("strikeprice","call.ltp","call.OI","put.ltp","put.OI","call.change","put.change")

df=cbind(strikeprice,call.ltp,call.openinterest,put.ltp,put.openinterest,call.netchange,put.netchange,call.changeOI,put.changeOI)
colnames(df)=c("strikeprice","call.ltp","call.OI","put.ltp","put.OI","call.change","put.change","call.changeOI","put.changeOI")

df=df[-1,]

numb=function(x){
x=as.numeric(as.character(x))
return(x)
}

df[1:9] = lapply(df[1:9], numb)
df[is.na(df)] = 0

require(dplyr)

Df=filter(df,(call.OI>0) | (put.OI>0))
      
Df=filter(Df,strikeprice<9000 & strikeprice>6500)      

Df$strikeprice=as.factor(as.character(Df$strikeprice))

    
#**********************************************************************************


remDr$close()
remDr$closeServer()


date=format(Sys.Date(), "%d-%m-%Y")
nr= nrow(Df)
nr=nr*0.1
nr=4.8-nr

Df$call=paste0(as.character(Df$call.ltp),"  [",as.character(Df$call.change),"]",sep="")
Df$put=paste0(as.character(Df$put.ltp),"  [",as.character(Df$put.change),"]",sep="")

write.csv(Df,"options.csv")
write.csv(cmp,"cmp.csv")

rm(list=ls())
 




