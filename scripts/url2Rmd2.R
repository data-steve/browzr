pacman::p_load(xml2, rvest, dplyr,RSelenium)

# devtools::install_github("leeper/rio")
asc <- function(xx) as.character(xx)


test_for_div <- function(tree) {
  out <- capture.output(html_structure(tree[[1]]))[1]
  if (grepl("div",out)){
    TRUE
  } else {
    return(gsub("<|>","",out))
  }
}

vec_url <- c("http://data-steve.github.io/need-user-feedback-send-programmatically/"  # basic jekyll
             , "http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/" # wp-plugin
             , "https://brendanrocks.com/htmlwidgets-knitr-jekyll/"    # jekyll, various code types and embedded svg
             , "http://www.bytemining.com/2016/02/its-been-a-while/"  # no code example
             , "http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/" #
             , "http://christophergandrud.blogspot.com/2015/05/a-link-between-topicmodels-lda-and.html" # blogger gist embedded
             , "http://www.r-bloggers.com/what-are-the-best-machine-learning-packages-in-r/"
             , "http://moderndata.plot.ly/trisurf-plots-in-r-using-plotly/" # crazy indented crayon tables
             , "http://www.r-statistics.com/2016/05/heatmaply-interactive-heat-maps/" # wp_codebox td.code pre
             , "http://r-norberg.blogspot.com/2016/06/understanding-datatable-rolling-joins.html" # bloggers, pre class , no p tags only div
             , "http://joelcadwell.blogspot.com/2016/06/building-data-matrix-for-task-at-hand.html" # blogger, no p tag, just open text
)


#if blogger, pre can be inserted at <br> level since there is no p tags

load_checker <- function(md){
  loaders <- c("library\\(","require\\(","p_load\\(")
  the_l <- loaders[sapply(loaders,function(x) any(grepl(x,md)))]
  if (length(the_l)==0){
    return("library")
  } else {
    return(the_l)
  }
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


test_for_ <- function(xx, f, tag){
  nm <-html_name(match.fun(f)(xx))
  if (any(tag %in% nm)){
    TRUE
  } else {
    nm[1]
  }
}


walk_for_ <- function(xx, direction, tag){
  f <- switch(direction,
              "up" = "xml_parent",
              "down" = "xml_children")

  while (isTRUE(test_for_(xx,f,tag))) {
    xx <- match.fun(f)(rvest::xml_nodes(xx, test_for_p(xx,f,tag)))
  }
  xx
}

# url_num <-grep("blogspot",vec_url)

check_for_gist <- function(xml_scrape){
  scrpts <- xml2::xml_attrs(rvest::xml_nodes(xml_scrape, "script"), "src")
  if (any(grepl("gist.github", scrpts))) {
    gsub(".js", "", scrpts[grepl("gist.github", scrpts)])
  } else {
    NULL
  }
}

download_gist <- function(gist_url){
  gist_page <- xml2::read_html(gist_url)

  gist_redirect <- paste0("https://gist.githubusercontent.com",
                          xml2::xml_attr(
                            xml2::xml_find_first(
                              xml2::xml_find_first(gist_page, xpath=".//div[contains(@class, 'file-actions')]")
                              ,"a") ,"href"))

  if (grepl("r|py",tolower(tools::file_ext(gist_redirect)))) {
    filename = file.path(tempdir(),"gist_content")
    curl::curl_download(gist_redirect,
                        destfile = filename)
    gist_content <- suppressWarnings(readLines(gist_redirect))
  } else {
    gist_content <- NULL
  }
  list("gist_content"=gist_content,file_type=tolower(tools::file_ext(gist_redirect)))
}

get_gist <-function(gist_urls){
  if (length(gist_urls)==1){
    download_gist(gist_urls)
  } else {
    invisible(lapply(gist_urls, download_gist))
  }
}
#
# url2Rmd <- function(url) {
#   xx    <- xml2::read_html(url)
#   title <- xml2::xml_text(rvest::xml_nodes(xx,"title"))
#   generator <- get_generator(xx)
#   # xml2::xml_attr(rvest::xml_nodes(xx,"meta"), "generator")
#   # test <- rvest::xml_nodes(xx,"body")
#
#   # xml2::xml_parent(rvest::xml_nodes(rvest::xml_nodes(xx,"body"), "p"))
#   # asc(xml_find_all(test,"//div/p"))
#   # xml2::xml_parent()
#
#   classes <-c("entry-content", "post-content", "post", "post-bodycody", "pf-content")
#   content_post <-names(which.max(sapply(classes,function(z) regexpr(z,asc(xx)))))
#   bdy <- xml_find_first(xx,xpath=paste0(".//div[contains(@class, ",shQuote(content_post),")]"))
#
#   if (length(bdy)==0){
#     bdy <- xml_find_first(xx,xpath=".//article")
#   }
#
#  browser()
#   # find and clean code chunks
#   # classes <-c("<pre>", "post-content", "post", "post-bodycody")
#   # grepl("<pre>", asc(bdy)) ".//pre"
#   # grepl("crayon-pre", asc(bdy)) ".//div[contains(@class, 'crayon-pre')]"
#   # grepl("td class=\"code", asc(bdy))
#   # xml_text(xml_nodes(bdy,xpath=".//pre"))
#   # if (grepl("<pre>", asc(bdy))){
#   pre_tags <- xml_nodes(bdy,xpath=".//pre")
#   if (length(pre_tags)!=0){
#     if (!any(grepl("<p>",xml_siblings(pre_tags)))) {
#       pre_tag_content <- pre_tags
#       pre_tag_container <- pre_tags
#
#
#       pre_tag_container <- walk_for_(pre_tag_container,"up","p")
#       xml2::xml_replace(pre_tag_container,pre_tags)
#
#
#     }
#
#     # my need to change for gutter numbers
#     # v1 <- xml2::xml_text(bdy[grepl("<pre>", asc(bdy))])
#     # if (any(grepl("(\\d\n)+", v1))) {
#     #   v1[grepl("(\\d+\n)+", v1)] <- gsub("^.+?(\\d+\n)+(\\s+|\n+)*", "", v1[grepl("(\\d+\n)+", v1)])
#     # }
#   }
#
#
#   # check for and get gists
#   gist_urls <- check_for_gist(bdy)
#   if (!is.null(gist_urls)){
#     gist_list <- get_gist(gist_urls)
#     script_tag <-xml_child(bdy,"script")
#     codechunk <- read_xml(paste0(
#                     htmltools::div(
#                       htmltools::pre(class=gist_list[["file_type"]]
#                                , htmltools::code(
#                                  shQuote(paste(gsub("#'","#"
#                                           ,gist_list[["gist_content"]]),collapse="\n")))
#                                      )) ))
#     if (grepl("\\$",codechunk)) {
#       codechunk <-  gsub("\\$","$", codechunk)
#     }
#     if (grepl("<code>\"",codechunk)) {
#       codechunk <- gsub("</code>\"", "</code>", gsub("<code>\"","<code>", codechunk))
#     }
#     invisible(xml_replace(script_tag, codechunk))
#   }
#
#   # div.my_syntax_box  -> <td class="code">
#   #   div.crayon-plain-wrap
#
#   md <- system(sprintf("echo %s | pandoc -r html  -t markdown", shQuote(asc(bdy)))
#                , intern = TRUE, ignore.stderr = TRUE)
#
#   hotbod <- gsub("```[ ]{0,1}\\{.*?\\}","```\\{r\\}",md[!grepl("<div|</div>|^\\\\",md)])
#   yml <- paste('---'
#                , 'title: "R Notebook"'
#                , 'output: html_notebook'
#                , '---'
#                , '\n\n', sep="\n")
#   filename <- paste0(paste(strsplit(tolower(title),"\\s+")[[1]],collapse="-"),".Rmd")
#   place <- file.path(tempdir(),filename)
#   writeLines(c(yml,paste0("# ", title), hotbod)  ,  place)
#   file.edit(place)
# }
#





#
# get_code <- function(xx){
#   browser()
#   ll <- xml2::xml_contents(xx)
#   has <- grepl("div",ll)
#   if (any(has)){
#     ll[has][[1]] <- code_converter(ll[has])
#     ll
#   } else {
#     bd_div
#   }
# }
#
# code_converter <- function(ll){
#   if (any(grepl('class="crayon-plain-wrap"',ll))) {
#     htmltools::code(html_text(xml_nodes(ll, "div.crayon-plain-wrap")))
#   } else if (grepl('class="code"',ll)) {
#     htmltools::code(html_text(xml_nodes(ll, "td.code")))
#   } else {
#     ll
#   }
# }
#
# read_text <- function(url,flnm){
#   d<-get_body(url)
#   place <- file.path(tempdir(),paste0(flnm,".md"))
#   writeLines(as.character(d),  place)
#   file.edit(place)
# }


# # walk up the nested nodes looking for p-tags
#
# test_for_p <- function(xx) {
#   chld <- xml2::xml_children(bdy)
#   nm <-html_name(chld)
#   if (any(nm %in% "p")){
#     TRUE
#   } else {
#     nm[1]
#   }
# }
#
# # walk down the nested nodes looking for p-tags
# while (isTRUE(test_for_p(bdy))) {
#   bdy <- xml2::xml_children(rvest::xml_nodes(bdy, test_for_p(bdy)))
# }

