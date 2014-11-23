
library(caret)

set.seed(42)

har <- read.csv("pml-training.csv", header = T)
trainIdx <- createDataPartition(har$classe, p = 0.7, list = F)

har.train <- har[trainIdx, ]
har.test <- har[-trainIdx, ]

har.train.X <- har.train[, -160]
har.train.Y <- har.train[, 160]
har.test.X <- har.test[, -160]
har.test.Y <- har.test[, 160]


as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

convertFactorToNumeric <- function(df){
  cols <- dim(df)[2]
  for(i in 1:cols){
    if(is.factor(df[, i])){
      df[, i] <- as.numeric.factor(df[, i])
    }
  }
  return(df)
}

colsWithLargeNumberNA <- function(df, NA.Threshold = 0.5){
  cols <- dim(df)[2]
  rows <- dim(df)[1]
  
  colsPastThreshold <- numeric()
  
  for(i in 1:cols){
    proportionMissing <- sum(is.na(df[, i]))/rows
    if(proportionMissing >= NA.Threshold){
      #print(i)
      colsPastThreshold <- c(colsPastThreshold, i)
      #print(colsPastThreshold)
    }
  }
  return(colsPastThreshold)
}


preProcessTrain <- function(X){
  #remove non-numeric and other miscellaneous data points
  colsToRemove <- c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", 
                    "cvtd_timestamp", "new_window", "num_window")
  colRemoveBool <- names(X) %in% colsToRemove
  X <- X[, !colRemoveBool]
  
  X <- convertFactorToNumeric(X)
  
  col.high.perc.NA <- colsWithLargeNumberNA(X)
  
  if(length(col.high.perc.NA) > 0){
    X <- X[, -col.high.perc.NA]
  }
  
  X.nzv <- nearZeroVar(X)
  
  if(length(X.nzv) > 0){
    X <- X[, -X.nzv]
  }
  return(X)
}

har.train.X.preproc <- preProcessTrain(har.train.X)



cols <- names(har.train.X.preproc)
har.train.X.preproc$outcome <- har.train.Y


test.pred <-  predict(modFit, har.test.X[, cols])
sum(test.pred == har.test.Y)/length(har.test.Y)

table(test.pred, har.test.Y)

trControl = trainControl(method="cv", number = 4)

modFit.dtree <- train(outcome~., data = har.train.X.preproc, method = "rpart")

modFit.knn <- train(outcome~., data = har.train.X.preproc, method = "knn", preProcess = c("pca"))

modFit.rf <- train(y = har.train.X.preproc$outcome, x = har.train.X.preproc[, -53], 
                   method = "rf", 
                   ntree = 150,
                   #mtry = 27,
                   trControl = trControl,
                   do.trace = 25,
                   tuneLength = 5)



#Final Model
modFit.rf <- randomForest(y = har.Y, x = har.X.preproc, ntree = 150, mtry = 27, do.trace = 25)

har.test <- read.csv("pml-testing.csv", header = T)

har.Y = har[, 160]
har.X = har[, -160]
har.X.preproc <- preProcessTrain(har.X)
cols <- names(har.X.preproc)

har.test.predict <- predict(modFit.rf, har.test[, cols])

pml_write_files = function(x){
  n = length(x)
  for(i in 1:n){
    filename = paste0("problem_id_",i,".txt")
    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
  }
}

pml_write_files(har.test.predict)