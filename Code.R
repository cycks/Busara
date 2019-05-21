#Import Data From Excel. The Template Sheet
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
vector <-c("category", "currency", "country_location")
####################
#Import data set
Fundraising <- read_csv("DS_Data Task_Fundraising.csv") %>%
  dplyr::mutate(deadline_date = as.Date(deadline_date, format = '%m/%d/%Y')) %>%
  dplyr::mutate(launch_time = as.Date(launch_time, format = '%m/%d/%Y')) %>%
  dplyr::mutate_if(is.character, as.factor) %>%
  dplyr::mutate(time_diff = deadline_date - launch_time) %>%
  dplyr::select(-c(launch_time, deadline_date, id)) %>%
  dplyr::mutate(category = as.numeric( factor(category) ) -1) %>%
  dplyr::mutate(currency = as.numeric( factor(currency) ) -1) %>%
  dplyr::mutate(country_location = as.numeric( factor(country_location) ) -1)

checking <- Fundraising %>%
  dplyr::select(c("goal_amount", "amount_pledged", "end_state", "num_backers",
                  "time_diff")) %>%
  dplyr::group_by(., end_state) %>%
  dplyr::summarise_all("mean")
View(checking)

ggplot(checking, aes(x=reorder(end_state, -goal_amount), y=goal_amount, fill=end_state)) +
  geom_bar(stat = "identity")


ggplot(checking, aes(x=reorder(end_state, -amount_pledged), y=amount_pledged, 
                     fill=end_state)) +
  geom_bar(stat = "identity")


ggplot(checking, aes(x=reorder(end_state, -num_backers), y=num_backers, fill=end_state)) +
  geom_bar(stat = "identity")

ggplot(checking, aes(x=reorder(end_state, -time_diff), y=time_diff, fill=end_state)) +
  geom_bar(stat = "identity")


