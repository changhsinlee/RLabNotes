library(mlbench)
data(PimaIndiansDiabetes)
pid <- PimaIndiansDiabetes
str(pid)
library(caret)
trainIndex = createDataPartition(pid$diabetes,
                                 p = .8,
                                 list = FALSE)

train <- pid[trainIndex,]
test <- pid[-trainIndex,]


fitControl <- trainControl(
  method = "cv",
  number = 5,
  # make caret use log-loss
  classProbs = TRUE,
  summaryFunction = mnLogLoss
)


logreg.model <-  train(diabetes ~ .,
              data = train,
              method = "glm",
              trControl = control,
              metric = "logLoss")

pred.prob <- predict(logreg.model, newdata=test, type="prob")




rf.model <- train(diabetes ~ .,
                  data = train,
                  method = "rf",
                  trControl = fitControl,
                  metric = "logLoss")

rf.model

svm.grid <- expand.grid(sigma=c(.1,.3,1,3,10), C=c(.1,.3,1,3,10))
svm.model <- train(diabetes ~ .,
                  data = train,
                  method = "svmRadial",
                  trControl = fitControl,
                  tuneGrid = svm.grid,
                  metric = "logLoss")

svm.model
