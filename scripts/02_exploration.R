## Load Packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(cl, dplyr, magrittr, tidyr, readr, ggplot2)


home <- cl::l_drive_go("swiper/PATH TO PROJECT HERE")


## Load Data
dat <- readr::read_csv(cl::go(home, "data/01_DATA FILE NAME HERE"))