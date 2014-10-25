library(shiny)
library(shinyapps)
library(ggplot2)
library(directlabels)
library(RCurl)

x <- getURL("https://raw.githubusercontent.com/geekbert/DevelopingDataProducts/master/WeeklyStockPrices2014.csv", ssl.verifypeer = FALSE)
y <- read.csv(text = x) 
y$DATE <- as.Date(y$DATE, format = "%m/%d/%Y")

dataset <-  y
 
shinyUI(pageWithSidebar(
 
  headerPanel("Stock Price Trends in the Software Industry"),
  
  sidebarPanel(
	h4('Relative change of selected stock prices in % since 1/1/2014'), 
	#helpText("View stock price trends, or ANY trend."),
	
	checkboxGroupInput("SYMBOL", label = h4("Select Stocks:"), c("DAX"="DAX","DOW JONES"="DOW JONES","FACEBOOK"="FACEBOOK", "NASDAQ100"="NASDAQ100", "SAP"="SAP", "SOFTWARE AG"="SOFTWARE AG", "TWITTER"="TWITTER"), selected=c("DAX"="DAX","DOW JONES"="DOW JONES","FACEBOOK"="FACEBOOK", "NASDAQ100"="NASDAQ100", "SAP"="SAP", "SOFTWARE AG"="SOFTWARE AG", "TWITTER"="TWITTER")), 
	#checkboxGroupInput("SYMBOL", "Names", c(levels(dataset$SYMBOL))), selected=c(levels(dataset$SYMBOL)))), 
		
	dateRangeInput("DATERANGE", label = h4("Select Date range:"), start  = "2014-01-01", end = "2014-10-13")  
			

  ),

  mainPanel(
	#h4('Trend Chart'),	 
	#textOutput("text1"), 
	#textOutput("text2"), 

    plotOutput('plot')
  )
))  
