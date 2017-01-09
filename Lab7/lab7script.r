
install.packages("mlbench")
library(mlbench)
data(package="mlbench")

library(dplyr)
library(broom)
library(ggplot2)
library(plotROC)

pid <- PimaIndiansDiabetes %>% 
  mutate(mass = ifelse(mass<5, NA, mass),
         pressure = ifelse(pressure<5, NA, pressure))

ggplot(pid, aes(x=pressure)) + geom_histogram()


glm.fit <- glm(diabetes ~ glucose, data = pid, family = binomial)
summary(glm.fit)

glucose.prob <- predict(glm.fit, type = "response")
contrasts(pid$diabetes)

glucose.pred <- ifelse(glucose.prob > .5, "p.pos", "p.neg")
table(glucose.pred, pid$diabetes)

pid %>% ggplot(aes(x=glucose, y=as.numeric(diabetes)-1)) + geom_jitter(height = .05, alpha=.2) + geom_smooth(method = "glm", method.args = list(family = "binomial"))#+ binomial_smooth()

data.frame(
  D = as.numeric(pid$diabetes)-1,
  M = glucose.prob
) %>% ggplot(aes(d=D, m=M)) + geom_roc()


# 
# glm.fit %>% augment(type.predict="response") %>% View
# 
# glm.fit %>% augment(type.predict="response") %>% ggplot(aes(x=.fitted, y=ifelse(diabetes=="pos", 1,0))) + geom_point(alpha=.3) + geom_smooth()
# 
# glm.fit %>% augment(type.predict="response") %>% ggplot(aes(x=pressure, y=ifelse(diabetes=="pos", 1,0))) + geom_point(alpha=.3) + geom_smooth()
# 
# glm.fit2 <- glm(diabetes2 ~ pedigree, data = pid, family = binomial)
# summary(glm.fit2)
# 
# fit2.prob <- predict(glm.fit2, type="response")
# fit2.pred <- ifelse(fit2.prob > .5, "pos", "neg")
# 
# new.pid <- pid %>% select(diabetes2) %>% mutate(pred = fit2.pred)
