require(RSelenium)
pJS <- phantom()
Sys.sleep(5) # give the binary a moment
remDr <- remoteDriver(browserName = 'phantomjs')
remDr$open()
remDr$navigate("http://www.google.com/ncr")
remDr$getTitle()[[1]] # [1] "Google"
remDr$close
pJS$stop() # close the PhantomJS process, note we dont call remDr$closeServer()
