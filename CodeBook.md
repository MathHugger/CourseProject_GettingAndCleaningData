## Detailed Code Book for run_analysis.R
* The first assumptoin is that you have already retrieved the data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and have upzipped all the raw files to your working directory. It is important to note that there should not be a directory for test and one for train. All files should be contained in the working directory
* The key files required are features.txt, activity_labels.txt, subject_test.txt, y_test.txt, x_test.txt, subject_train.txt, y_train.txt, x_train.txt
* Step 1: import the common data - the features.txt and activity_labels.txt
* Stpe 2: import the test data - subject_test.txt, y_test.txt, x_test.txt
* A couple key transformations occur in the second step - 1) run numbers are added to each record.  This is to ensure all merged data lines up correctly; 2) column names are added to the x_test.txt data for better description; 3) Many of the 561 columns within x_test are removed as the assignment requested to only focus on those with mean() and std().  Out of the 561, only 66 were kept; 4) a group label is applied to the x_test.txt data to signify it came from the test group
* Step 3: merges subject_test.txt, y_test.txt, x_test.txt together into one file that contains the key 66 variables along with the subject, activity, activity_number, and group
* Steps 4 & 5: replicates steps 2 and 3 but for the train data
* Step 6: the test and train data is appended into one table called final_output
* Step 7: in order to prodoce the tidy data set that takes average of the 66 variables by subject and activity, a melt and dcast is performed.  In order to do so, the run, activity_number, and group columns are removed.  The tidy_averages data set represents averages across the 180 combinations (30 subjects and 6 activities)
* Step 8: the tidy_averages table is outputted to the working director as a tab delimited file

## Column Descriptions
* The original data descriptions can be found within the readme.md at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
* run - which run# was associated with the experiment.  Run can be considered a trial or a single set of data collected for an event.  Run is only unique within a group
* activity_number - this is a unique number by activity.  The corresponding activity can be found in the activity column
* subject - which of the 30 subjects generated the data
* activity - which of 6 activities were being performed?
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING
* group - was the subject part of the test or train group?
* The data collected is below.  There is data for both the mean() and the std()
tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag
