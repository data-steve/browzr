
cells$cell_type
lapply(cells$source,
ipynb_parser <- function(ipynb){
  cells <- jsonlite::flatten(jsonlite::fromJSON(readLines(ipynb))$cells)
  contents <- data.frame(cell_type = cells[["cell_type"]], stringsAsFactors = F )
  contents$source <- unlist(
    lapply(1:length(cells[["source"]]), function(i) {
      ifelse(is.null(cells[["source"]][i]),NA, paste(cells[["source"]][15],","))
    }))
  contents$outputs <- unlist(
          lapply(1:length(cells$outputs), function(i) {
          ifelse(is.null(cells$outputs[[i]]$text),NA, unlist(cells$outputs[[i]]$text))
        }))
  contents[is.na(contents)] <- ""
  contents
}

ipynb <- "~/Desktop/test.ipynb"
curl::curl_download("https://raw.githubusercontent.com/julienr/ipynb_playground/master/misc_ml/curse_dimensionality.ipynb", "~/Desktop/test.ipynb")
test_ipynb <- ipynb_parser("~/Desktop/test.ipynb")

jsonlite::toJSON(test_ipynb) %>% jsonlite::prettify()




