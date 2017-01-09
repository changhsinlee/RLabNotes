View(nba.shots)

data.nba <- select(nba.shots, GAME_ID, player_name, MATCHUP, PERIOD, SHOT_NUMBER, TOUCH_TIME, PTS_TYPE, SHOT_RESULT, PTS)
data.nba <- filter(data.nba, player_name %in% c("kobe bryant","james harden"))
data.nba <- group_by(data.nba, GAME_ID, player_name)
data.nba <- mutate(data.nba, total_time = cumsum(TOUCH_TIME))
summary.nba <- summarize(data.nba, 
                         total_shots = n(),
                         total_time = max(total_time),
                         total_pts = sum(PTS),
                         pts_per_time = total_pts / total_time)
summary.nba <- arrange(summary.nba, desc(pts_per_time))

data.nba2 <- nba.shots %>%
  select(GAME_ID, player_name, MATCHUP, SHOT_NUMBER, TOUCH_TIME, SHOT_DIST, PTS_TYPE, SHOT_RESULT, PTS) %>%
  filter(player_name %in% c("kobe bryant","james harden"), PTS_TYPE == 2) %>%
  group_by(GAME_ID, player_name) %>%
  mutate(total_time = cumsum(TOUCH_TIME)) %>%
  summarize(total_shots = n(),
            total_time = max(total_time),
            total_pts = sum(PTS),
            pts_per_time = total_pts / total_time) %>%
  arrange(desc(pts_per_time))
  



data.nba <- mutate(data.nba, pts_per_time = PTS / (TOUCH_TIME + .3))
