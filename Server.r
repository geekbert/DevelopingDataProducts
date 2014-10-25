library(shiny)
library(shinyapps)
library(ggplot2)
library(directlabels)
library(RCurl)

x <- getURL("https://raw.githubusercontent.com/geekbert/DevelopingDataProducts/master/WeeklyStockPrices2014.csv", ssl.verifypeer = FALSE)
y <- read.csv(text = x) 
y$DATE <- as.Date(y$DATE, format = "%m/%d/%Y")

dataset <-  y
 
 
shinyServer(function(input, output) {
	
	#output$text1 <- renderText({paste("You have selected", input$SYMBOL)})
 	
	output$plot <- renderPlot({   
	    
	dataset <- dataset[dataset$SYMBOL  %in% paste(input$SYMBOL), ] # I HAD big trouble subsetting df by multiple factors 
	
	# subset by date:  dataset[dataset$DATE <= "2014-10-13" & dataset$DATE >= "2014-09-22", ]
	dataset <- dataset[dataset$DATE <= paste(input$DATERANGE[2]) & dataset$DATE >= paste(input$DATERANGE[1]), ]   
	#dataset <- dataset[dataset$DATE <= paste(input$DATERANGE), ] # this works 
	#print(str(dataset)) 
	p <- ggplot(data=dataset, aes(x=DATE, y=RELATIVE_CHANGE, colour=SYMBOL)) + geom_line(aes(group=SYMBOL)) 
	p <- direct.label(ggplot(data=dataset, aes(x=DATE, y=RELATIVE_CHANGE, colour=SYMBOL)) + geom_line())
	print(p)
   
    
  }, height=700)
  
})


