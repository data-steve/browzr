## Load Packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(cl, dplyr, magrittr, tidyr, readr, ggplot2)


home <- cl::l_drive_go("swiper/PATH TO PROJECT HERE")


## Load Data
dat <- readr::read_rds(cl::go(home, "data/00_DATA FILE NAME HERE"))



## Saved Cleaned Data
readr::write_csv(cl::go(home, "data/01_CLEAN DATA"))