library(xml2)
library(rvest)
library(stringr)
get_values <- function(){
  page <- read_html("https://www.care.gov.eg/EgyptCare/Index.aspx")
  values <- page%>% html_nodes("[class='progress-value']")%>%html_text()
  values <- as.numeric(gsub("([0-9]+).*$", "\\1", values))
  return(as.numeric(c(values[1],values[2] , values[6])))
}
