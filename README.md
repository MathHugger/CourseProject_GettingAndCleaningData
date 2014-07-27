CourseProject_GettingAndCleaningData
====================================

This houses the code, md file, and code book for the course assignment for Getting and Cleaning Data

### Data Preparation
* The first assumptoin is that you have already retrieved the data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and have upzipped all the raw files to your working directory.  It is important to note that there should not be a directory for test and one for train.  All files should be contained in the working directory
* The key files required are features.txt, activity_labels.txt, subject_test.txt, y_test.txt, x_test.txt, subject_train.txt, y_train.txt, x_train.txt

### What does run_analysis.R do? 
* At the highest level, the R program merges multiple data sets into one, provides clarity to column names, and then aggregates some information by subject and activity
* Each file is loaded and then column names are changed to be more intuitive and user friendly.  There are several QA checks that are commented out but a user can simply run those to confirm they get the same answers
* Some reshaping of data is performed - 1) a "run" number is added for each run of data collection; 2) as mentioned, better column names are given; 3) the columns that are not mean or std are removed per instructions
* There is a final_output table that merges all data from subject and test and then adds columns to identfity the subject, activity number, activity, as well as what group they were in (subject or test)
* Then, there is a tidy_averages output table that melts the final_output so that averages by subject and activity can be provided.  There are 180 records in this table (30 subjects and 6 activities)
