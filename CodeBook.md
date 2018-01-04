Getting and Cleaning Data Assignment Code book

Study Design

The data for this assignment comes from accelerometers on a Samsung Galaxy S II smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, 
where 70% of the volunteers was selected for generating the training data and 30% the test data. 

More information on the experiment can be found at: https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data for the project is downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_Analysis.R script downloads the dataset and does the following functions:

1. Merges the training and the test sets to create one data set.
The original files are merges into the following data frames:

test_data
test_labels
test_subjects
train_data
train_labels
train_subjects

combine_data
combine_labels
combine_subjects

2. Extracts only the mean and standard deviation for each measurement.

This step imports the variable names for measurement data. It finds the only the columns that contain variables that are the mean and standard deviation of measurements.

features - This variables imports the dataset containing the measurement variable names
meanstdcols - Finds the positions in features which only contain variables that are for mean and standard deviation for measurements
dataMeanStd - subset of combine_data with only the columns of variables that mean and standard deviations of measurements

3. Uses descriptive activity names to name the activities in the data set
The activity labels dataset contains the descriptive names of the activities linked with its corresponding numeric id. This is combined with the combine_labels dataset 

activitynames - imported dataset with linking numeric coded activity with descriptive name
activities - output dataset that contains descriptively named activities for each row of the dataset

4. Appropriately labels the data set with descriptive variable names.
The measurement variable names for the mean and standard deviation variables are extracted from the features dataset and used to name the columns of the dataMeanStd data subset. 

dataLabels - Variable labels for the dataMeanStd dataset. mean() and std() are changed to Mean and SD for readability. Hyphens are left in the variable names for readability.
combineall - Final dataset with descriptive variable names combining the columns for the combine_subjects, activities, and dataMeanStd dataframes.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The combineall dataset is sorted by subject and activity for readability. Then a dataset is output that gives the Mean for each measurement variable for each Subject+Activity combination. Each measurement variable name is prefaced with "Mean_" to indicate such.

meansummary - Outputs a dataset sorted by subject and activity with the mean for measurement variable for each combination of subject+activity.