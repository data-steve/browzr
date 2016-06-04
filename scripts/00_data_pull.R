## Load Packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(cl, clDatabases, dplyr, magrittr, tidyr, ggplot2)


home <- cl::l_drive_go("swiper/PATH TO PROJECT HERE")

## Fetch Data from SQL (produc is either: "CourseEval", "Beacon", or "Baseline")
dat <- get_SQL_data(product = 'PRODUCT HERE', input = cl::go(home,"scripts/PATH TO SQL SCRIPT HERE"))

## Save to External File
saveRDS(dat, cl::go(home,"data/00_NAME OF DATA HERE.rds"))
