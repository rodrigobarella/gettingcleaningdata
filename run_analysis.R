## The following script was designed to collect and clean Samsung dataset. The final output of this
## script is a tidy dataset that can be used for further analysis

##-------------------------------------------------------------------------------------------------
##--------------------------------Before running analysis------------------------------------------
##-------------------------------------------------------------------------------------------------

## it is necessary to have the Samsung dataset in your working directory
## inside a folder called 'data'

## In case the required dataset is not available, run the following code to properly download
## and unzip the required files in your working directory. 

## It is also possible to manually download
## the files and create a folder called 'data'. Unzip the file inside 'data' directory

## Creating folder to store raw data

if(!file.exists("./data")){dir.create(path="./data")}

## Download and unzip dataset

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL,destfile="./data/downloaded_data.zip")

unzip(zipfile="./data/downloaded_data.zip",exdir="./data")

##-------------------------------------------------------------------------------------------------
##--------------------------------Pre-processing script--------------------------------------------
##-------------------------------------------------------------------------------------------------

## 1. Merging training and test sets to create one data set

## Reading features and response data for the train and test sets

Xtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")

Ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt",col.names="Activity")
Ytest <- read.table("./data/UCI HAR Dataset/test/y_test.txt",col.names="Activity")

## Reading subject data for train and test set
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names="Subject")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names="Subject")

## Binding features training and test sets 
X <- rbind(Xtrain,Xtest)

## Binding response training and test sets
Y <- rbind(Ytrain,Ytest)

## Binding subject trainning and test sets
subject <- rbind(subject_train,subject_test)

## Binding subject, features and response columns to create one dataset
data <- cbind(subject,Y,X)

## 2 - Extracting only the measurements on the mean and standard deviation for each measurement. 

## Reading the labels of each feature
labels <- read.table("data/UCI HAR Dataset/features.txt")

## Selecting features labeled with mean() and std() in the features list
means <- grep("mean()",labels$V2,fixed=T)
stdev <- grep("std()",labels$V2,fixed=T)

## selected features (only mean and std)
selected_feat <- sort(c(means,stdev),decreasing=F)

## adding 2 to the columns number to account for first and second columns (Subject and Acitivy)
idx <- 2+selected_feat

## subsetting data corresponding to selected features 
data <- data[,c(1,2,idx)]

## 3 - Using descriptive activity names to name the activities in the data set

## Reading activities labels
activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")

## Attributing activities labels to factor levels 1 through 6
data$Activity <- factor(data$Activity,labels=activities[,2])

## 4 - Appropriately labels the data set with descriptive variable names. 
## attribting labels of the selected features (mean and std) 
names(data)[3:ncol(data)] <- as.character(labels[selected_feat,2])

## 5 - Creating an indepentent tidy data set with the average of each variable for each activity and each subject.

## 'ddply' function from 'plyr' package was used to generate a summarized data frame with the column means 
library(plyr)

summarizedData <- ddply(data[,3:ncol(data)],.(data$Subject,data$Activity),.fun=colMeans,na.rm=T)

## Attributing names of the first two columns of the summarized data frame
names(sumData)[c(1,2)] <- c("Subject","Activity")

## Writting new tidy data set in a '.txt' file  
write.table(summarizedData,file="tidydataset.txt",row.names=F)
