#compare with https://gist.github.com/expersso/bb03efcab2a6c125da5ac22e1c33d070

url <- "https://github.com/daattali/addinslist/blob/master/README.md#list-of-addins"
url2 <- "https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population"

get_html_tables <- function(url, which=NULL){
  xx <- xml2::read_html(url)
  xx <- rvest::xml_nodes(rvest::xml_node(xx,"body"),"table")
# browser()
  if (!is.null(which)) {
      if (is.numeric(which)){
          return(xx[which])
        } else {
          return(xx[grep(which, xx)])
        }
    } else {
      xx
    }
}


tt2 <- get_html_tables(url2,"Rank in")
grep("Rank in", tt2)
tt2[[2]]
rvest::xml_node(tt2,"tbody")
rvest::xml_nodes(,'tr')


lapply(tt2, function(x){
  browser()
  stats::setNames(tr_to_df(x),tr_to_nms(x))
})

tr_to_nms <- function(tbl){
  tbl_tr <- rvest::xml_nodes(rvest::xml_nodes(tbl,"thead"),'tr')
  tbl_tr <- sapply(tbl_tr, function(x) gsub("(<th/>)", "<th>''</th>", x))
  sapply(tbl_tr, function(x) {
    strsplit(gsub("(<tr>\n<th>)|(</th>\n</tr>)","",x),"(</th>\n<th>)")[[1]]
  } , USE.NAMES=FALSE)
}

tr_to_df <- function(tbl){
  tbl_df <- rvest::xml_nodes(rvest::xml_nodes(tbl,"tbody"),'tr')
  tbl_df <-sapply(tbl_df, function(x) gsub("(<td/>)", "<td>''</td>", x))
  as.data.frame(
    t(sapply(tbl_df, function(x) {
      strsplit(gsub("(<tr>\n<td>)|(</td>\n</tr>)","",x),"(</td>\n<td>)")[[1]]
    }, USE.NAMES = F))
    ,stringsAsFactors=FALSE)
}

get_tables <- function(url, which=NULL){
  xml_tables <- get_html_tables(url, which)
  if (length(xml_tables)>1){
    lapply(xml_tables, function(x){
      stats::setNames(tr_to_df(x),tr_to_nms(x))
    })
  } else {
    stats::setNames(tr_to_df(xml_tables),tr_to_nms(xml_tables))
  }
}

df2 <- get_tables(url2)
dplyr::glimpse(df)
install.packages("XML")
df2<-XML::readHTMLTable("https://en.wikipedia.org/wiki/List_of_U.S._states_and_territories_by_population")
