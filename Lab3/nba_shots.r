
# Come up with a figure that shows Kobe Bryant's shooting percentage distribuion with respect to distance

shots.pct <- select(nba.shots, MATCHUP, player_name, SHOT_DIST, SHOT_RESULT, PTS_TYPE)
View(arrange(shots.pct,SHOT_DIST))

shots.pct <- mutate(shots.pct, PTS_TYPE = factor(PTS_TYPE), RESULT = factor(SHOT_RESULT))
shots.pct <- filter(shots.pct, player_name == "kobe bryant")

plot.shots.pct <- ggplot(data=shots.pct, aes(x=SHOT_DIST, fill=RESULT))
plot.shots.pct + geom_histogram(binwidth = 5, alpha=.3, position="stack")

