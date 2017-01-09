library(caret)
library(dplyr)

## Preparing data/Preprocessing
data(mdrr)
mdrrDescr <- mdrrDescr[, -nearZeroVar(mdrrDescr)] # remove predictors with near zero variance
mdrrDescr <- mdrrDescr[, -findCorrelation(cor(mdrrDescr), .5)] # remove highly correlated predictors


# Create training/test data
set.seed(123)
indTrain <- createDataPartition(mdrrClass, p=.5, list=FALSE)
trainX <- mdrrDescr[indTrain, ]
testX <- mdrrDescr[-indTrain, ]

training.data <- mutate(
  trainX, 
  Label = mdrrClass[indTrain])
test.data <- mutate(
  testX, 
  Label = mdrrClass[-indTrain])

# Create different model fits of LDA and QDA (ignore warning messages)
trCtrl <- trainControl(
  classProbs = TRUE
)
ldaFit <- train(Label ~ .,
                data = training.data,
                method = "lda",
                trControl = trCtrl)
qdaFit <- train(Label ~ .,
                data = training.data,
                method = "qda",
                trControl = trCtrl)

# Put observed labels and probability prediction in one data frame
testProbs <- data.frame(
  obs = test.data$Label,
  lda = predict(ldaFit, test.data, type="prob")$Active,
  qda = predict(qdaFit, test.data, type="prob")$Active
  )

# Create calibration data
calibration(obs ~ lda + qda, data = testProbs)
calPlotData <- calibration(obs ~ lda + qda, data = testProbs)
calPlotData

# Calibration plot
xyplot(calPlotData, auto.key = list(columns = 2))

