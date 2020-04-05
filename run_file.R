rm(list=ls(all=TRUE))
setwd("D:/work/git corona/")
cat("\n ------------------- \n" , format(Sys.time()),"\n")
library(lubridate)
args = commandArgs(trailingOnly=TRUE)
cond <- 0 
if(length(args)==0){
  cond <- readline(prompt="Please press 1 for new row and press 2 for Run Scraper: ")
}else{
  cond <- as.numeric(args[1])
}
if(cond == 1){
  new_cases <- as.numeric(readline(prompt="Enter new cases: "))
  new_deaths <- as.numeric(readline(prompt="Enter new deaths: "))
  total_recovered <- as.numeric(readline(prompt="Enter total recovered: "))
  df <- read.csv("eg_covid.csv")
  rw <- df[nrow(df),]
  rw$Day <- format(Sys.Date(),"%m/%d/%Y")
  rw$New.Cases <- new_cases
  rw$Total.Cases <- as.numeric(rw$Total.Cases)+new_cases
  rw$New.Deaths <- new_deaths
  rw$Total.Deaths <- rw$Total.Deaths + new_deaths
  rw$New.Recovered <- total_recovered - rw$Total.Recovered
  rw$Total.Recovered <- total_recovered
  rw$New.Deaths...60 <- new_deaths
  df <- rbind(df , rw)
  write.csv(df,"eg_covid.csv",row.names = F)
  cat("New Recored add\n")
}else if( cond == 2){
  source('Scraper.R')
  values <- get_values()
  df <- read.csv("eg_covid.csv")
  rw <- df[nrow(df),]
  new_cases <- values[1]
  new_deaths <- values[2]
  total_recovered <- values[3]
  if(new_cases == rw$New.Cases & new_deaths==rw$New.Deaths & total_recovered == rw$Total.Recovered){
    cat("Nothing new\n")
    stop("Nothing new\n")
  }else{
    rw$Day <- format(Sys.Date(),"%m/%d/%Y")
    rw$New.Cases <- new_cases
    rw$Total.Cases <- as.numeric(rw$Total.Cases)+new_cases
    rw$New.Deaths <- new_deaths
    rw$Total.Deaths <- rw$Total.Deaths + new_deaths
    rw$New.Recovered <- total_recovered - rw$Total.Recovered
    rw$Total.Recovered <- total_recovered
    rw$New.Deaths...60 <- new_deaths
    df <- rbind(df , rw)
    write.csv(df,"eg_covid.csv",row.names = F)
    cat("Automaticlly New Recored add\n")
  }
}
cat("Running rmarkdown file ...\n")
rmarkdown::render(input = "Corona.Rmd", output_file = "index.html")

