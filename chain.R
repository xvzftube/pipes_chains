library(dplyr)

df_diamonds <- read.csv("diamonds.csv")

df_diamonds %>%
  select(color, price) %>%
  group_by(color) %>%
  summarize(avg_price = mean(price)) %>%
  mutate(high_end = ifelse(avg_price > 5000, 1, 0))

