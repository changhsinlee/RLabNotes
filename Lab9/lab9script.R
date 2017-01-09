library(caret)
library(dplyr)
library(ggplot2)
library(broom)

data(Boston, package="MASS")

#set.seed(1234)
indTrain <- createDataPartition(
  y = Boston$medv, # response variable
  p = .8, # percentage of training data
  list = FALSE # resulted in a vector of indices
)

training <- Boston[indTrain,] # training set
test <- Boston[-indTrain,] # test set

num_folds <- 5
# create CV folds from training
#set.seed(1234)
folds <- createFolds(
  y = training$medv,
  k = num_folds,
  list = TRUE
)


# train linear regression
lm.predict <- list()
for (i in 1:num_folds){
  lm.fit <- lm(medv ~ lstat, data = training[-folds[[i]], ])
  lm.predict[[i]] <- data.frame(
    medv = training[folds[[i]],]$medv,
    pred = predict(lm.fit, newdata = training[folds[[i]],])
  )
}


lm.RMSE <- numeric()
for (i in 1:num_folds){
  lm.RMSE[i] <- summarize(lm.predict[[i]], RSE = sqrt(mean((medv - pred)^2))) %>% unlist
}

mean(lm.RMSE)

lm.fit.all  <- lm(medv ~ lstat, data=training)
predict.all <- data.frame(
  medv = test$medv,
  pred = predict(lm.fit.all, newdata = test)
)
RMSE.all <- predict.all %>% summarize(RSE = sqrt(mean((medv - pred)^2))) %>% unlist
RMSE.all



