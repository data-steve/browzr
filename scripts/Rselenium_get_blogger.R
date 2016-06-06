RSelenium_get_blogger <- function(url){
  #start RSelenium
  RSelenium::checkForServer()
  RSelenium::startServer()
  remDr <- RSelenium::remoteDriver()
  remDr$open()

  #navigate to your page
  remDr$navigate(url)

  #scroll down 5 times, waiting for the page to load at each time
  for(i in 1:2){
    remDr$executeScript(paste("scroll(0,",i*10000,");"))
    Sys.sleep(3)
  }

  #get the page html
  remDr$getPageSource()[[1]]
}
