## This script performs the following functions:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Merges the training and the test sets to create one data set
#Step 1: Load package

library(dplyr)

#Step 2: download zip file containing data. (Skip this step if done)

zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

#Step 3: unzip zip file containing data if data directory doesn't already exist

dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}

#Step 4: read Training Data

trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

#Step 5: read Test Data

testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))

#Step 6: read Features

features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)

#Step 7: read Activity Labels

activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")


#Step 8: combine data tables

humanActivity <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)

#Step 9: Clean Global Environment of redundant variables

rm(trainingSubjects, trainingValues, trainingActivity, 
   testSubjects, testValues, testActivity)

#Step 10: assign column names

colnames(humanActivity) <- c("subject", features[, 2], "activity")


##Extracts only the measurements on the mean and standard deviation for each measurement.
#Step 11: determine columns of data set to keep 

columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))

humanActivity <- humanActivity[, columnsToKeep]

humanActivity$activity <- factor(humanActivity$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

##Use descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names
#Step 12: get column names
humanActivityCols <- colnames(humanActivity)

#Step 13: remove special characters
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

#Step 14: renaming 
humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

#Step 15: correct spelling errors
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

#Step 16: use new labels as column names
colnames(humanActivity) <- humanActivityCols

##Create tidy set with mean values

#Step 17: grouping and summarising
humanActivityMeans <- humanActivity %>% 
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

#Step 18: output to file 
write.table(humanActivityMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)