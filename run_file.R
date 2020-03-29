rm(list=ls(all=TRUE))
setwd("D:/work/git corona/")
library(lubridate)
cond <- readline(prompt="Please press 1 for new row and press 2 for Run: ")
if(cond == 1){
  new_cases <- as.numeric(readline(prompt="Enter new cases: "))
  new_deaths <- as.numeric(readline(prompt="Enter new deaths: "))
  total_recovored <- as.numeric(readline(prompt="Enter total recovored: "))
  df <- read.csv("eg_covid.csv")
  rw <- df[nrow(df),]
  rw$Day <- format(Sys.Date(),"%m/%d/%Y")
  rw$New.Cases <- new_cases
  rw$Total.Cases <- as.numeric(rw$Total.Cases)+new_cases
  rw$New.Deaths <- new_deaths
  rw$Total.Deaths <- rw$Total.Deaths + new_deaths
  rw$New.Recovered <- total_recovored - rw$Total.Recovered
  rw$Total.Recovered <- total_recovored
  rw$New.Deaths...60 <- new_deaths
  df <- rbind(df , rw)
  write.csv(df,"eg_covid.csv",row.names = F)
}
rmarkdown::render(input = "Corona.Rmd", output_file = "index.html")

