## Craig Snodgrass
## July 27, 2014

## Getting And Cleaning Data Course Project
## End result should be - 
## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Step 1 - Import, Create Clean Variable Names, and Merge the Data

library("data.table")
library("plyr")
library("reshape2")

#########################################################################
##### shared metadata
#########################################################################

##### features #####
features <- read.table("features.txt")
colnames(features) <- c("feature_number", "feature")
## head(features)
## Don't want $feature to be a factor so need to change to character
## str(features)
features[,2] <- as.character(features[,2])
## str(features)

##### activity #####
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activity_number", "activity")
## head(activity_labels)
## str(activity_labels)
## Don't want $activity to be a factor so need to change to character
activity_labels[,2] <- as.character(activity_labels[,2])
## str(activity_labels)

#########################################################################
##### test data
#########################################################################

##### subject test #####
subject_test <- read.table("subject_test.txt")
colnames(subject_test) <- c("subject_number")
subject_test <- data.frame('run' = c(1:nrow(subject_test)), subject_test)
## head(subject_test)
## str(subject_test)
## nrow(subject_test) ## 2947

##### activity test #####
y_test <- read.table("y_test.txt")
colnames(y_test) <- c("activity_number")
y_test <- data.frame('run' = c(1:nrow(y_test)), y_test)
## head(y_test)
## str(y_test)
## nrow(y_test) ## 2947

##### output test #####
x_test <- read.table("x_test.txt")
## 561 columnas need to be renamed
for (i in 1:ncol(x_test)){
        colnames(x_test)[i] = features[i,2]
}
## head(x_test[, 1:5])
## str(x_test[, 1:5])

## according to assignment, only need the mean() and std() data
## I am assuming we don't need meanfreq
mean_features <- features[grep("mean(", features$feature, fixed=TRUE),]
std_features <- features[grep("std(", features$feature, fixed=TRUE),]
x_test <- x_test[, c(mean_features[, 1], std_features[,1])]
x_test <- data.frame('group' = "test", x_test)
x_test <- data.frame('run' = c(1:nrow(x_test)), x_test)

## head(x_test)
## nrow(x_test) ## Still 2947
## ncol(x_test) ## down to 68 (with adding one for run an group)

x <- merge(subject_test, y_test, by ="run",)
x <- merge(x, activity_labels, by = "activity_number",)
x_test <- merge(x, x_test, by="run")
## head(x_test)
## str(x_test)
## nrow(x_test) ## Stil 2947
## ncol(x_test) ## 71 since added subject and activity

#########################################################################
##### train data
#########################################################################

##### subject train #####
subject_train <- read.table("subject_train.txt")
colnames(subject_train) <- c("subject_number")
subject_train <- data.frame('run' = c(1:nrow(subject_train)), subject_train)
## head(subject_train)
## str(subject_train)
## nrow(subject_train) ## 7352

##### activity train #####
y_train <- read.table("y_train.txt")
colnames(y_train) <- c("activity_number")
y_train <- data.frame('run' = c(1:nrow(y_train)), y_train)
## head(y_train)
## str(y_train)
## nrow(y_train) ## 7352

##### output train #####
x_train <- read.table("x_train.txt")
## 561 columnas need to be renamed
for (i in 1:ncol(x_train)){
        colnames(x_train)[i] = features[i,2]
}
## head(x_train[, 1:5])
## str(x_train[, 1:5])

## according to assignment, only need the mean() and std() data
## I am assuming we don't need meanfreq
x_train <- x_train[, c(mean_features[, 1], std_features[,1])]
x_train <- data.frame('group' = "train", x_train)
x_train <- data.frame('run' = c(1:nrow(x_train)), x_train)

## head(x_train)
## nrow(x_train) ## Still 7352
## ncol(x_train) ## down to 68 (with adding one for run and one for group)

x <- merge(subject_train, y_train, by ="run",)
x <- merge(x, activity_labels, by = "activity_number",)
x_train <- merge(x, x_train, by="run")
## head(x_train)
## str(x_train)
## nrow(x_train) ## Stil 7352
## ncol(x_train) ## 71 since added subject and activity

#########################################################################
##### final output table
#########################################################################

final_output <- rbind(x_test, x_train)

#########################################################################
##### tidy average
#########################################################################

x.temp <- subset(final_output, select = -c(run, activity_number, group))
## the above drops the columns that aren't needed
x_melt <- melt(x.temp, id = c("subject_number", "activity"))
tidy_averages <- dcast(x_melt, subject_number + activity ~ variable, mean)

## head(tidy_averages)
## ncol(tidy_averages) ## 68.  The original 66 plus subect and activity
## nrow(tidy_averages) ## 180.  30 subects and 6 activities per = 180

write.table(tidy_averages, "tidy_averages.txt", sep = "\t")
