## Load Packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(cl, dplyr, magrittr, tidyr, ggplot2, readr)


home <- cl::l_drive_go("swiper/PATH TO PROJECT HERE")


## Load Data
dat <- readRDS(cl::go(home, "data/DATA FILE NAME HERE")) %>%
        tbl_df() 