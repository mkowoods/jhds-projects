
library(caret)

set.seed(42)

har <- read.csv("pml-training.csv")
trainIdx <- createDataPartition(har$classe, p = 0.7, list = F)

har.train <- har[trainIdx, ]
har.test <- har[-trainIdx, ]

har.train.X <- har.train[, -160]
har.train.Y <- har.train[, 160]
har.test.X <- har.test[, -160]
har.test.Y <- har.test[, 160]


as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

preProcess <- function(har.data){
  #remove cases where new_window is set to yes
  har.data <- subset(har.data, har.data$new_window == "no")
  colsToRemove <- c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", 
                    "cvtd_timestamp", "new_window", "num_window")
  colRemoveBool <- names(har.data) %in% colsToRemove
  har.data <- har.data[, !colRemoveBool]
  har.data.nzv <- nearZeroVar(har.data)
  har.data <- har.data[, -har.data.nzv]
  return(har.data)
}