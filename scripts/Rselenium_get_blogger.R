RSelenium_get_blogger <- function(url){
  #start RSelenium
  RSelenium::checkForServer()
  RSelenium::startServer()
  remDr <- RSelenium::remoteDriver(remoteServerAddr = "localhost"
                                   , port = 4444
                                   , browserName = "firefox" )
  Sys.sleep(0.5)
  remDr$open()
  Sys.sleep(0.5)

  #navigate to your page
  remDr$navigate(url)

  #scroll down 5 times, waiting for the page to load at each time
  for(i in 1:2){
    remDr$executeScript(paste("scroll(0,",i*10000,");"))
    Sys.sleep(1)
  }

  #get the page html
  x <- remDr$getPageSource()[[1]]
  # remDr$getTitle()[[1]]
  remDr$close()
  remDr$closeServer()
  remDr$quit()
  x
}

