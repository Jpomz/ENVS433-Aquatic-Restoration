# document to source for pre data results

library(tidyverse)
library(RcppRoll)
pre <- read_csv(here::here("data/IHA/pre_data.csv"))
# do all the steps above and save it in a new R object called `group1_pre` 
group1_pre <- pre %>%
  group_by(m) %>%
  summarize(m_mean = mean(cfs))
# print out your new object to see it in the console
# group1_pre

pre_g2_1d <- pre %>%
  group_by(y) %>%
  summarise(min_1 = min(cfs), 
            max_1 = max(cfs)) %>%
  summarise(m_min_1 = mean(min_1), 
            m_max_1 = mean(max_1))
# 3-day min and max
pre_g2_3d <- pre %>%
  group_by(y) %>%
  reframe(mean_3 = roll_mean(cfs, n = 3)) %>%
  group_by(y) %>%
  summarise(min_3 = min(mean_3),
            max_3 = max(mean_3)) %>%
  summarise(m_min_3 = mean(min_3),
            m_max_3 = mean(max_3))

# pre_g2_3d

# 7-day min and max
pre_g2_7d <- pre %>%
  group_by(y) %>%
  reframe(mean_7 = roll_mean(cfs, n = 7)) %>%
  group_by(y) %>%
  summarise(min_7 = min(mean_7),
            max_7 = max(mean_7)) %>%
  summarise(m_min_7 = mean(min_7),
            m_max_7 = mean(max_7))

# pre_g2_7d
pre_g2_30d <- pre %>%
  group_by(y) %>%
  reframe(mean_30 = roll_mean(cfs, n = 30)) %>%
  group_by(y) %>%
  summarise(min_30 = min(mean_30),
            max_30 = max(mean_30)) %>%
  summarise(m_min_30 = mean(min_30),
            m_max_30 = mean(max_30))

#pre_g2_30d
# 90-day min and max
pre_g2_90d <- pre %>%
  group_by(y) %>%
  reframe(mean_90 = roll_mean(cfs, n = 90)) %>%
  group_by(y) %>%
  summarise(min_90 = min(mean_90),
            max_90 = max(mean_90)) %>%
  summarise(m_min_90 = mean(min_90),
            m_max_90 = mean(max_90))

#pre_g2_90d

# combine all the columns of results for the 5 windows into one object
pre_g2 <- bind_cols(pre_g2_1d,
                    pre_g2_3d,
                    pre_g2_7d,
                    pre_g2_30d,
                    pre_g2_90d) %>%
  # make the data "long" instead of wide
  pivot_longer(cols = starts_with("m_"), names_to = "metric", values_to = "mean_cfs") %>%
  # separate the first column into multiple columns
  separate(metric, c("drop", "metric", "day-window")) %>%
  # remove the "drop" column (it's unneeded)
  select(!drop)  

# print out the new object to see what it looks like
#pre_g2


### Calculations Group 3  
pre_min_julian <- pre %>%
  group_by(y) %>%
  filter(cfs == min(cfs)) %>%
  select(cfs, y, j_date) %>%
  ungroup() %>%
  summarise(min_j_date = mean(j_date))

#pre_min_julian
pre_max_julian <- pre %>%
  group_by(y) %>%
  filter(cfs == max(cfs)) %>%
  select(cfs, y, j_date) %>%
  ungroup() %>%
  summarise(min_j_date = mean(j_date))

#pre_max_julian
