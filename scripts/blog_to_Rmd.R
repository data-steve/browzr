url2Rmd <- function(url) {

  xx    <- xml2::read_html("http://r-norberg.blogspot.com/2016/06/understanding-datatable-rolling-joins.html")
  generator <- get_generator(xx)

  if (generator =="blogger") {
    x <- invisible(RSelenium_get_blogger("http://r-norberg.blogspot.com/2016/06/understanding-datatable-rolling-joins.html"))

    xx <- xml2::read_html(x, encoding = "UTF-8")
  }

  title <- xml2::xml_text(rvest::xml_nodes(xx,"title"))

  # xml2::xml_attr(rvest::xml_nodes(xx,"meta"), "generator")
  # test <- rvest::xml_nodes(xx,"body")

  # xml2::xml_parent(rvest::xml_nodes(rvest::xml_nodes(xx,"body"), "p"))
  # asc(xml_find_all(test,"//div/p"))
  # xml2::xml_parent()

  classes <-c("entry-content", "post-content", "post", "post-bodycody", "pf-content", "entry", "article")
  content_post <-names(which.max(sapply(classes,function(z) regexpr(z,asc(xx)))))
  bdy <- xml2::xml_find_first(xx,xpath=paste0(".//div[contains(@class, ",shQuote(content_post),")]"))
  # browser()
  if (length(bdy)==0){
    bdy <- xml2::xml_find_first(xx,xpath=".//article")
    # chld <- paste(xml2::xml_children(bdy),collapse="")
    # bdy <- xml2::xml_add_child(xml2::read_xml("<div>\n</div>"),chld)
  }


  # find and clean code chunks
  # classes <-c("<pre>", "post-content", "post", "post-bodycody")
  # grepl("<pre>", asc(bdy)) ".//pre"
  # .//crayon-plain-wrap
  # grepl("crayon-pre", asc(bdy)) ".//div[contains(@class, 'crayon-pre')]"
  # grepl("td class=\"code", asc(bdy))
  # xml_text(xml_nodes(bdy,xpath=".//pre"))
  # if (grepl("<pre>", asc(bdy))){  paste0(".//div[contains(@class, ",shQuote(content_post),")]")
  codeclasses <- c('crayon-plain-wrap','crayon-plain-tag','<pre')
  codeclass <-  codeclasses[sapply(codeclasses,function(z) regexpr(z,asc(xx)))>-1][1]
  codepath <-c("div//.[contains(@class, 'crayon-plain-wrap')]","div//.[contains(@class, 'crayon-plain-tag')]", ".//pre")
  pre_tags <- xml2::xml_find_all(bdy,xpath=codepath[grep(gsub("<","",codeclass), codepath)] )
  # pre_tags2 <- rvest::xml_nodes(bdy,xpath=".//pre")
  if (length(pre_tags)!=0){


    pre_tag_content <- pre_tags
    pre_tag_container <- pre_tags

    pre <- lapply(pre_tag_content, function(z) {paste0(
        htmltools::pre(class="r"
                       , htmltools::code(
                         # sQuote(
                           paste(xml_text(z),collapse="\n")
                         # )
        ) )
      )})

    pre_tag_content <-  xml2::xml_find_all(xml2::read_xml(paste(c("<div>",pre , "</div>"), collapse="")),"pre")

    if (!any(grepl("<p>|<div",xml2::xml_parent(pre_tags)))) {
      pre_tag_container <- walk_for_(pre_tag_container,"up","p|div")
    }
    invisible(xml2::xml_replace(pre_tag_container,pre_tag_content))


  }

    # my need to change for gutter numbers
    # v1 <- xml2::xml_text(bdy[grepl("<pre>", asc(bdy))])
    # if (any(grepl("(\\d\n)+", v1))) {
    #   v1[grepl("(\\d+\n)+", v1)] <- gsub("^.+?(\\d+\n)+(\\s+|\n+)*", "", v1[grepl("(\\d+\n)+", v1)])
    # }



  # check for and get gists
  gist_urls <- check_for_gist(bdy)
  if (!is.null(gist_urls)){
    gist_list <- get_gist(gist_urls)
    script_tag <-xml_child(bdy,"script")
    codechunk <- read_xml(paste0(
      htmltools::div(
        htmltools::pre(class=gist_list[["file_type"]]
                       , htmltools::code(
                         sQuote(paste(gsub("#'","#"
                                            ,gist_list[["gist_content"]]),collapse="\n")))
        )) ))
    if (grepl("\\$",codechunk)) {
      codechunk <-  gsub("\\$","$", codechunk)
    }
    if (grepl("<code>\"",codechunk)) {
      codechunk <- gsub("</code>\"", "</code>", gsub("<code>\"","<code>", codechunk))
    }
    invisible(xml_replace(script_tag, codechunk))
  }
# bdy
  # div.my_syntax_box  -> <td class="code">
  #   div.crayon-plain-wrap
# n_bdy <- gsub("</article>", "</div>", gsub("<article", "<div", asc(bdy)))
# gsub("</html>", "<body><div>hi</div></body></html>",(rvest::minimal_html("testing")))
# md <- system(sprintf("echo '%s' | pandoc -r html  -t markdown", gsub("</html>", "<body><div>hi</div></body></html>",rvest::minimal_html("testing")))
#              , intern = TRUE, ignore.stderr = TRUE)

  cmd <-sprintf("echo %s | pandoc -r html  -t markdown", shQuote(asc(bdy)))
  md <- system(cmd , intern = TRUE, ignore.stderr = TRUE)

  hotbod <- gsub("```[ ]{0,1}\\{.*?\\}","```\\{r\\}",md[!grepl("<div|</div>|^\\\\|^\"$|^style=",md)])
  # hotbod <- gsub("\"</code>|\'</code>|’</code>|’’</code>", "</code>", gsub("<code>\"|<code>\'|<code>‘<code>‘‘","<code>", hotbod))

  yml <- paste('---'
               , 'title: "R Notebook"'
               , 'output: html_notebook'
               , '---'
               , '\n\n', sep="\n")
  filename <- paste0(paste(strsplit(tolower(title),"\\s+")[[1]],collapse="-"),".Rmd")
  place <- file.path(tempdir(),filename)
  writeLines(c(yml,paste0("# ", title), hotbod)  ,  place)
  file.edit(place)
}
