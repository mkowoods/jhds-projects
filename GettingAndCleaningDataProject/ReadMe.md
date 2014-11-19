## Getting and Cleaning UCI HAR Dataset

#Step 1: Download and Extract Data
* Download Data to your working Directory from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* unzip file into the working directory.  There should now be the folder "UCI HAR Dataset" in the working directory
* Run the Script

#Step 2: Run Script
1. Initially the Script reads the  "X...", "y..." and "subject..." txt files from the test/train folder into data.frames
2. Next it reads in the features.txt file to gather column headers for the "X" data table features
3. Next, the variable meanStdFeatures is defined which is a boolean mask indicating if the variable name
   contains substring  "mean()" or "std()"
4. Using the pre-defined boolean mask we extract the mean and std dev columns from the train and test versions of the X data.frame 
5. cbind is used to merge the "subject", "y" and "X" tables from test and train respectively, creating a test and train data.frame
6. rbind is used to stack the test and train data.frames
7. Descriptive activities(WALKING, STANDING, etc.) are mapped to the numerical values in the y tables by first making the "y" column a factor then applying the "levels" to that factor by loading the data from the "activity_labels.txt" file.
8. Col Names are staged in the data_names vector. The first 2 cols are "subject" and "activity", corresponding to the "subject" and "y" dataframes/files. The remaining column names are determined by applying the boolean mask(meanStdFeatures) to the feature names dataframe to extract the corresponding name for each column.
9. In order to summarize the data we first determined the unique combinations of "subject" and "activity" using the unique() function, then iterated over each of those unique pairs of subject and activity and passed the values as filters to the original dataframe(now called data_all). We computed the column mean for columns 3 through 68 (the mean() and std() columns of the original X matrix) for each subset of the original data frame and passed the results as a row to a temp matrix("results").
10. The columns of the "results" matrix, are then added to the final data.frame and the column names are added to the data.frame after doing a minor string concatenation to rename them "mean("Name of Original Column")."
11. The final data.frame is written to the file data.txt using the write.table command with the parameter row.names set to false

NB: Intermittently throughout the code we remove any stray variables to minimize memory overhead and to leave the namespace
relatively clean.

### Because of the number of columns in the dataset viewing the data in browser may be difficult. In order to read the data please use the command read.table(file, header = TRUE). Where file is the path to the tidy data set.





