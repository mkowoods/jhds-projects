
#Loading in test/train DataSets
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")


#Loading Features Dataset
X_features <-  read.table("UCI HAR Dataset/features.txt")

#Identifying(bool vector)  X Features that contain the term "mean()" and "std()"
meanStdFeatures <- (grepl("mean\\(\\)", X_features$V2))|(grepl("std\\(\\)", X_features$V2))

#Subsetting Cols from X_test and X_train that refer to mean and std calculations
X_test_meanStdFeatures <- X_test[, meanStdFeatures]
X_train_meanStdFeatures <- X_train[, meanStdFeatures]

#Building Test Data Set and Dropping Original Files
test_data <- cbind(subject_test, y_test, X_test_meanStdFeatures)
rm(subject_test, y_test, X_test, X_test_meanStdFeatures)

#Building Train Data Set and Dropping Original Files
train_data <- cbind(subject_train, y_train, X_train_meanStdFeatures)
rm(subject_train, y_train, X_train, X_train_meanStdFeatures)


#Combining Test and Train data Sets
data_all <- rbind(test_data, train_data)
rm(test_data, train_data)

#Replacing Activity ID's with Descriptive ID's from activity_labels.txt
#Below Approach assumes that  there a 6 levels and 6 factors and that the data 
#in activity_labels.txt is ordered 1 - 6 
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
data_all[, 2] <- factor(data_all[, 2])
levels(data_all[, 2]) <- as.character(activities[, 2])
rm(activities)


#Assigning Col Names
data_names <- rep(NA, 2 + sum(meanStdFeatures))
data_names[1] <- "subject"
data_names[2] <- "activity"
data_names[3:length(data_names)] <- as.character(X_features$V2[meanStdFeatures])
names(data_all) <- data_names

rm(data_names, X_features, meanStdFeatures)

groups <- unique(data_all[, c("subject", "activity")])

rows <- dim(groups)[1]
cols <- dim(data_all)[2]

results <- matrix(nrow = rows, ncol = (cols - 2))
#results[,1:2] <- as.matrix(groups)

for(i in 1:rows){
    d <- data_all[(data_all$subject == groups[i, 1])
                  &(data_all$activity == groups[i, 2]), 3:cols]
    results[i,] <- colMeans(d)
}

for(j in 1:(cols - 2)){
    col_name <- paste("mean(",colnames(data_all)[j + 2],")",sep = "")
    groups[col_name] <- results[,j]    
}


write.table(x = groups, file = "data.txt", row.names = F)
    
rm(data_all, groups, results, col_name, i, j, cols, rows, d)




