pacman::p_load(xml2, rvest, dplyr, jsonlite)

home <- getwd()
asc <- function(xx) as.character(xx)
test <- rvest::xml_nodes(bd_div,"div")
test[grep("<p>",asc(test))]

xml2::xml_text()


test_for_div <- function(tree) {
  out <- capture.output(html_structure(tree[[1]]))[1]
  if (grepl("div",out)){
    TRUE
  } else {
    return(gsub("<|>","",out))
  }
}

while (isTRUE(test_for_div(test))) {
  test <- xml2::xml_parent(rvest::xml_nodes(rvest::xml_nodes(xx,"body"), test_for_div(test)))
}
if ()
test <- xml2::xml_parent(test)

url2Rmd <- function(url) {
  xx    <- xml2::read_html(vec_url[5])
  title <- xml2::xml_text(rvest::xml_node(xx,"title"))
    # xml2::xml_attr(rvest::xml_nodes(xx,"meta"), "generator")
  test <- xml2::xml_parent(rvest::xml_nodes(rvest::xml_nodes(xx,"body"), "p"))

  while (!grepl("<div>",capture.output(html_structure(test[[1]]))[1])) {
    test <- xml2::xml_parent(test)
    }
  if () {
    xml2::xml_parent(test)
  }

  body  <-xml2::xml_contents(xml2::xml_parent(rvest::xml_nodes(rvest::xml_nodes(xx,"body"), "pre")))
   rvest::xml_nodes(,"div")
   v1 <- xml2::xml_text(body[grepl("<pre>", asc(body))])
   body[grepl("<pre>", asc(body))]  <- lapply(v1, htmltools::code)

  # rvest::xml_nodes(bd,"div.entry-content")

  # generator <- get_generator(xx)
  # get_body(xx)


}




url2Rmd <- function(url) {
  xx   <- xml2::read_html(url)
  title <- xml2::xml_text(rvest::xml_node(xx,"title"))
  generator <- get_generator(xx)
  get_body(xx)

}
  find/clean body content
  find/clean code chunks


  body_html <- as.character(divs)
  md <- system(sprintf("echo %s | pandoc -r html  -t markdown", shQuote(body_html))
               , intern = TRUE, ignore.stderr = TRUE)
  body <- gsub("```[ ]{0,1}\\{.*?\\}","```\\{r\\}",md[!grepl("<div|</div>|^\\\\",md)])
  yml <- paste('---'
               , 'title: "R Notebook"'
               , 'output: html_notebook'
               , '---'
               , '\n\n', sep="\n")
  filename <- paste0(paste(strsplit(tolower(title),"\\s+")[[1]],collapse="-"),".Rmd")
  place <- file.path(tempdir(),filename)
  writeLines(c(yml,paste0("# ", title), body)  ,  place)
  file.edit(place)
}

get_generator <- function(xx){
    x <- as.character(xx)
    if (any(grepl("wp-",x)) ) {
      "wordpress"
    } else if (any(grepl("blogger[.]",x))) {
       "blogger"
     } else {
    "jekyll"
     }
}

get_body <- function(xx) {
  bd <- rvest::xml_nodes(xml2::read_html(xx),"body")
  if (grepl('entry-content',bd)) {
    rvest::xml_nodes(bd,"div.entry-content")
  } else {
    rvest::xml_nodes(bd,"div.post")
  }
}

x5<-get_body(x5)

get_code <- function(xx){
  browser()
    ll <- xml2::xml_contents(xx)
    has <- grepl("div",ll)
    if (any(has)){
      ll[has][[1]] <- code_converter(ll[has])
      ll
    } else {
      bd_div
    }
}

code_converter <- function(ll){
  if (any(grepl('class="crayon-plain-wrap"',ll))) {
      htmltools::code(html_text(xml_nodes(ll, "div.crayon-plain-wrap")))
    } else if (grepl('class="code"',ll)) {
      htmltools::code(html_text(xml_nodes(ll, "td.code")))
    } else {
      ll
    }
}

get_code(x4)






read_text <- function(url,flnm){
  d<-get_body(url)
  place <- file.path(tempdir(),paste0(flnm,".md"))
  writeLines(as.character(d),  place)
  file.edit(place)
}

read_text(u3,"x3")



  grep('class="code"',as.character(x2))
    grep('class="code"',x2)


    locs <- grepl(".my_syntax_box",divs)
    if (any(locs)) {
      to_cl <- writeLines(as.character(divs[locs][5]),"~/Desktop/test44.md")
      as.character(to_cl)
    } else {
      divs
    }

  }
}




#####

urm <- function(urls){
  rvest::xml_node(xml2::read_html(urls),"body")
}

u1 <- "http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/"
x1   <- urm(u1)

u2 <- "http://data-steve.github.io/making-ggdumbbell-smarter/"
x2   <- urm(u2)

u3 <- "http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/"
x3   <- urm(u3)

u4 <- "http://www.bytemining.com/2016/02/its-been-a-while/"
x4   <- urm(u4)

x5 <- "http://rogiersbart.blogspot.com/2016/04/a-workflow-for-publishing-rstudio.html"

http://brendanrocks.com/htmlwidgets-knitr-jekyll/

  as.character(xml2::read_html("http://brendanrocks.com/htmlwidgets-knitr-jekyll/"))


# strsplit(tolower(xml2::xml_text(rvest::xml_node(xx,"title"))),"\\s+")[[1]][1]
# divs <- rvest::xml_nodes(rvest::xml_node(xx,"body"),"div.post")
# writeLines(x,"~/Desktop/test45.md")
# file.edit("~/Desktop/test45.md")

# http://rogiersbart.blogspot.com/2016/04/a-workflow-for-publishing-rstudio.html

url2Rmd(urlz)



div.my_syntax_box  -> <td class="code">
div.crayon-plain-wrap


writeLines(as.character(x3),"~/Desktop/test43.md")
file.edit("~/Desktop/test43.md")





load_checker <- function(md){
  loaders <- c("library\\(","require\\(","p_load\\(")
  the_l <- loaders[sapply(loaders,function(x) any(grepl(x,md)))]
  if (length(the_l)==0){
    return("library")
  } else {
    return(the_l)
  }
}
loader <- load_checker(test2)

find_


vec_url <- c("http://data-steve.github.io/need-user-feedback-send-programmatically/"
             , "http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/"
             , "https://brendanrocks.com/htmlwidgets-knitr-jekyll/"
             , "http://www.bytemining.com/2016/02/its-been-a-while/"
             , "http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/"
             , "http://christophergandrud.blogspot.com/2015/05/a-link-between-topicmodels-lda-and.html"
             , "http://citizen-statistician.org/2016/02/02/how-do-readers-perceive-the-results-of-a-data-analysis/"
             , "http://civilstat.com/2016/04/after-5th-semester-of-statistics-phd-program/")

test2 <-url2md("http://data-steve.github.io/need-user-feedback-send-programmatically/")

grep("```",test2)

zz <-







src    <- strsplit(paste(zz,collapse="\n"),"```")[[1]]
src2 <- lapply(src, function(x) paste0(strsplit(x, "\n")[[1]],"\n"))
cell_type <- ifelse(as.logical(rep(c(0,1),length(src))[1:length(src)]), "code","markdown")

contents <- data.frame(cell_type = cell_type, stringsAsFactors = F)
contents$source <- c(NA,NA,NA)
contents$outputs <- "[]"

contents$source <- unlist(lapply(1:length(contents$cell_type), function(i) {
    paste(shQuote(src2[[i]]),collapse = ",")
}))


paste(toJSON(conte))

jptr <- list()
jptr$cells <- toJSON(contents)
jptr$metadata <- jj
list()
jsonlite::validate(jsonlite::toJSON(contents))
writeLines(jsonlite::prettify(jsonlite::toJSON(contents)),"~/Desktop/test2.ipynb")


jj <- fromJSON(readLines(cl::go(home, "data/jupyter-metadata.txt")))

cells <- toJSON(contents)

test <-list(toJSON(contents),toJSON(jj))

prettify(test)

z2[]
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
