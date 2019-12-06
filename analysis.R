library(ggplot2)
library(lubridate)
library(dplyr)

df <- read.csv("data/london_merged.csv")

df$season  <- factor(df$season, labels = c("Spring", "Summer", "Fall", "Winter"))
df$hour <- factor(hour(ymd_hms(df$timestamp)))

first_graph  <-
  df %>%
  group_by(season, hour) %>%
  summarise(mcount = mean(cnt)) %>%
  ggplot(aes(x = hour, y = mcount, colour = season)) +
  geom_line(aes(group = season)) +
  theme_bw() +
  geom_point()


second_graph <-
  df %>%
  group_by(season) %>%
  summarise(mcount = mean(cnt)) %>%
  ggplot(aes(x = reorder(season, mcount), y = mcount, fill = season)) +
  geom_bar(stat = 'identity') +
  labs(x = 'senson', y = 'mcount') +
  guides(fill = 'none') +
  theme_minimal()
