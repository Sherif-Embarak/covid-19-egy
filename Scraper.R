library(xml2)
library(rvest)
library(stringr)
get_values <- function(){
  page <- read_html("https://www.care.gov.eg/default.html")
  values <- page%>% html_nodes("[class='progress-value']")%>%html_text()
  return(as.numeric(c(values[3],values[2] , values[4])))
}
