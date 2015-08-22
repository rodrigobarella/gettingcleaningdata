## Getting and cleaning data - Samsung Galaxy S accelerometers

This repository contains the R script 'run_analysis.R', that was designed to download and clean data from Samsung Galaxy S smartphone accelerometers;

'run_analysis.R' features 5 functionalities:

  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The outputs of this script are:

  1. A tidy dataset with measurements on the mean and standard deviation for each measurement (genetated in step 4)
  2. Independent data set summarizing the average of each variable for each activity and subject

More informations on the dataset can be found at the following URL:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The used data can be downloaded in the following link:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
