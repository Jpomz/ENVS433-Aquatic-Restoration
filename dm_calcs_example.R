# example of how to run DM and %D calculations

library(tidyverse)

# run the pre-data calcs and put the data objects in your environment
# pre calcs
source("iha_pre_source_for_key.R")
# post calcs
source("iha_post_source_for_key.R")


(group1_post - group1_pre) / group1_pre * 1000

(post_g2_1d - pre_g2_1d) / pre_g2_1d * 100 
(post_g2_3d - pre_g2_3d) / pre_g2_3d * 100 
(post_g2_7d - pre_g2_7d) / pre_g2_7d * 100 
(post_g2_30d - pre_g2_30d) / pre_g2_30d * 100 
(post_g2_90d - pre_g2_90d) / pre_g2_90d * 100 


(post_min_julian - pre_min_julian) / pre_min_julian * 100

(post_max_julian - pre_max_julian) / pre_max_julian * 100

