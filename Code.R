#Import Data From Excel. The Template Sheet
setwd("~/Desktop/My Files/Projects/BraveVentures")
libs <- c("dplyr", "magrittr", "ggplot2", "readxl", "caret", "tidyr", "GGally",
          "data.table",  "plotly", "lubridate", "mice", "lettercase",
          "base", "plyr", "readr")
install_or_load_pack <- function(pack){
  create.pkg <- pack[!(pack %in% installed.packages()[, "Package"])]
  if (length(create.pkg))
    install.packages(create.pkg, dependencies = TRUE)
  lapply(libs, require, character.only = T, warn.conflicts=T, quietly=T)
}
install_or_load_pack(libs)

Check_case<- function(df){data.frame(lapply(df, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))
}

####################
#Import data set
Fundraising <- read_csv("DS_Data Task_Fundraising.csv") %>%
  mutate(deadline_date = as.Date(deadline_date, format = '%m/%d/%Y')) %>%
  mutate(launch_time = as.Date(launch_time, format = '%m/%d/%Y'))
View(Fundraising)
table(Fundraising$end_state)
