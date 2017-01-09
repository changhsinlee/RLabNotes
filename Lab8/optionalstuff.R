
## Lift curve?

## Calibration of probability 

(Optional, logistic regression always well-calibrated.)
Classification error rate is not a proper measure in algorithm design. A good classification model should have its probabilityo outputs *well-calibrated*. A calibration plot can be thought of the generalization of the fitted value v.s. true value plot to a classification problem. A *well-calibrated* probability prediction means ???. As an example, in the `Titanic` dataset, if I put all the passengers with roughly 50% of surviving probability into a bin, then in this bin the true surviving rate should also be roughly 50%. In other words, if the model's probability prediction is in line with past observations, then it is likely that the will work well for new data under similar conditions. 


Make a plot of 10 bins versus 10 bins.
