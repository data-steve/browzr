pacman::p_load(dplyr, pandocfilters, jsonlite,tidyjson, xml2, rvest)

tt %>% jsonlite::fromJSON()

library(rvest)

ex <- xml2::read_html("http://data-steve.github.io/need-user-feedback-send-programmatically/")

url <- "http://data-steve.github.io/need-user-feedback-send-programmatically/"
url2md <- function(url) {
  xx   <- xml2::read_html(url)
  title <- paste0("---\ntitle: ", xml_text(xml_node(xx,"title")), "\n---\n")
  divs <- xml_nodes(xml_node(xx,"body"),"div")
  body_html <- as.character(divs[max(grep("<p>",divs))])
  md <- system(sprintf("echo %s | pandoc -r html  -t markdown", shQuote(body_html))
         , intern = TRUE, ignore.stderr = TRUE)
  c(title, md[!grepl("<div|</div>|^\\\\",md)])
}


test2 <-url2md("http://data-steve.github.io/need-user-feedback-send-programmatically/")
writeLines(test2,"~/Desktop/test.md")


pndc <- function (url, to_file = FALSE, file = NA){
  if (!to_file) {
    system(paste0("pandoc -r html  ", url, " -t markdown")
           , intern = TRUE, ignore.stderr = TRUE)
  }
  else {
    if (is.na(file)) stop(message("file must not be NA"))
    system(paste0("pandoc -r  html  ", url, " -o ", file)
           , intern = TRUE, ignore.stderr = TRUE)
  }
}

html_md <- function(urlvec){
  if(length(urlvec)>1){
      lapply(1:length(urlvec), function(x){
        pndc(urlvec[x]
              , to_file=TRUE
              , file= file.path(path.expand("~/Desktop"),paste0("blogtest/new/test",x,".md") ) )
            })
  } else {
    pndc(urlvec
         , to_file=TRUE
         , file= file.path(path.expand("~/Desktop"),paste0("blogtest/new/test.md") ) )

  }
}



pandoc_to_json <- function(file, from="markdown") {
  args <- sprintf("-f %s -t json %s", from, file)
  system2("pandoc", args, stdout=TRUE, stderr=FALSE)
}





test_filter <- function(x, to="html") {
  d <- list(list(unMeta=setNames(list(), character())), x)
  pandoc_from_json(as.character(jsonlite::toJSON(d, auto_unbox=TRUE)), to=to)
}


file <- "~/Documents/repos/github_packages/browzr/data/test.md"

# pandoc -f markdown -t json ~/Documents/repos/github_packages/browzr/data/test.md
test <- readLines(file)

tt <- jsonlite::toJSON(test)

tt2 <- pandoc_to_json(file)
tt2 <- sub("S pace","Space",tt2)
jj <- jsonlite::fromJSON(tt3,  simplifyVector = T)

tt2

as.list(tt2[1])
strsplit(tt2[1],"},")

writeLines(paste(tt2,collapse=""), "~/Documents/repos/github_packages/browzr/data/tt2.md")

  regexpr("S",tt3)

rmd <- jsonlite::toJSON("~/", auto_unbox=TRUE)
lapply(rmd, is.block)

vec_url <- "http://data-steve.github.io/making-ggdumbbell-smarter/"
html_md(vec_url)

ll <- jsonlite::toJSON(vec_url)


lapply(ll,print)


length(ll)
example_1 <- file.path(system.file(package = "pandocfilters"), "examples", "lower_case.md")
# the file before transformation
ll <-readLines(example_1)

# read connection
input_connection <- textConnection(pandoc_to_json(ll, from="markdown"))
# write connection
output_connection <- textConnection("modified_ast", open="w")

# apply filter
filter(caps, input=input_connection, output=output_connection)

# convert altered ast to markdown
pandoc_from_json(modified_ast, to="markdown")



lapply(ll, pandocfilters::is.block)

# pndc("http://data-steve.github.io/making-ggdumbbell-smarter/"
#      , to_file=TRUE
#      , file= file.path(path.expand("~/Desktop"),paste0("blogtest/new/test1.md") ) )
#
#
#
vec_url <- c("http://data-steve.github.io/need-user-feedback-send-programmatically/"
             , "http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/"
             , "https://brendanrocks.com/htmlwidgets-knitr-jekyll/"
             , "http://www.bytemining.com/2016/02/its-been-a-while/"
             , "http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/"
             , "http://christophergandrud.blogspot.com/2015/05/a-link-between-topicmodels-lda-and.html"
             , "http://citizen-statistician.org/2016/02/02/how-do-readers-perceive-the-results-of-a-data-analysis/"
             , "http://civilstat.com/2016/04/after-5th-semester-of-statistics-phd-program/")












home <- "~/Desktop/blogtest"

xx <- lapply(grep("test",dir(home), value = T), function(x) readLines(cl::go(home, x)))
             'abc(\n|.)*?efg'
grep("</div>(\n|\"\"|.)*?</div>",xx[[1]], perl = T )
system("awk '/<\/div>/,/<\/div>/,/<\/div>/!d' ~/Desktop/blogtest/test.md")
xx[[1]][!sapply(xx[[1]],function(x) grepl("<div|</div",x), USE.NAMES = F)]





# scraper for ending
body <- xx[[1]]
hits <- rep(0, length(body))
hits[grep("^\\s*</div>\\s*$", body)] <- 1
hits[grep("^\\s*$", body)] <- 2


# distinguish different blogging platforms
# they likely have different conventions
# for making start, stop, code chunks....
find_blogger <- function(x){
  any(grep("generator: blogger", x))
}

sapply(xx, find_blogger)

find_wordpress <- function(x){
  any(grep("generator.*?wordpress", x, ignore.case = T))
}

sapply(xx, find_wordpress)

find_other  <- function(x){
  !any(grep("generator:", x, ignore.case = T))
}

sapply(xx, find_other)



# noticed that most use "=footer" to make end of content
sapply(xx, function(x)  min(grep("footer",x)) )


sapply(xx, function(x) {
  y<-min(grep("footer",xx[[8]]), na.rm = T)
  x[(y-20):(y+20)]
  })

gregexpr("12121", paste(hits, collapse=""))

locs <- lapply(gregexpr("12121", paste(hits, collapse=""))[[1]], function(x) x:c(x + 4))

