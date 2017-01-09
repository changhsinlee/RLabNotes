library(mlbench)
library(dplyr)
library(ggplot2)

data(PimaIndiansDiabetes)
pid <- PimaIndiansDiabetes

View(pid)

# Use pedigree and age
range(pid$pedigree)
range(pid$age)


grid.pedigree <- seq(0, 2.5, length.out=30)
grid.age <- seq(20,84, by=2)

grid <- expand.grid(
  age = grid.age,
  pedigree = grid.pedigree
  )

glm.fit <- glm(diabetes ~ age + pedigree,
               data = pid,
               family = binomial)

grid.prob <- predict(
  glm.fit,
  newdata = grid,
  type = "response"
)

grid <- grid %>%
  mutate(
    grid.prob = grid.prob,
    grid.pred = ifelse(grid.prob > .5, "pos", "neg"))

des.plot <- ggplot(data = grid, aes(x=age, y =pedigree)) +
  geom_point(mapping=aes(color=grid.pred), size=0.5) +
  geom_point(data = pid, mapping=(aes(x=age,y=pedigree,color=diabetes)))

des.plot + geom_contour(data = grid, aes(x=age,y=pedigree,z=grid.prob), binwidth=.5, size=1.2)




### knn


library(class)
library(mlbench)
library(dplyr)
data(Ionosphere)
ion <- select(Ionosphere, -V1, -V2)
ion.train <- ion[1:200,]
ion.test <- ion[-(1:200),]

train.data <- ion.train %>% select(-Class)
test.data <- ion.test %>% select(-Class)
train.label <- ion.train$Class
test.label <- ion.test$Class

knn.pred <- knn(train.data, test.data, train.label, 5)

