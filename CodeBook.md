---
title: "Code Book"
output: html_document
---

##Goal
The goal of the project is to prepare tidy data by the rules: 
https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project
R script "run_analysis.R" is designed for this purpose. 
The script creates two files "Result.csv" and "ResultMean.csv" in the Working Directory. The files contain tidy data sets.

##Input data set
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Input data for this project are located in:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Data reading
Before reading the data should be unzipped into the data directory "UCI HAR Dataset" and the data directory "UCI HAR Dataset" must be placed in the R Working Directory.
Files of data set is reading into temporary data frames (file - data frame):

* UCI HAR Dataset\\test\\X_test.txt - X_test
* UCI HAR Dataset\\train\\X_train.txt - X_train
* UCI HAR Dataset\\features.txt - features
* UCI HAR Dataset\\test\\y_test.txt - y_test
* UCI HAR Dataset\\train\\y_train.txt - y_train
* UCI HAR Dataset\\test\\subject_test.txt - subject_test
* UCI HAR Dataset\\train\\subject_train.txt - subject_train
* UCI HAR Dataset\\activity_labels.txt - activity


##Description of the data preparation 
###1. Merges the training and the test sets to create one data set.
This phase consists of two steps:

* Merges pairs of data frames  "X_test", "X_train", "y_test", "y_train", "subject_test", "subject_train" into data frame "Result"
* naming variables of "Result"

###2. Extracts only the measurements on the mean and standard deviation for each measurement.
Extracts only the measurements of "Result" including lines "mean(" and "std(".

###3. Uses descriptive activity names to name the activities in the data set.
Uses descriptive activity names (values of variable "activity" of "Result" data set) from faile "UCI HAR Dataset\\activity_labels.txt".

###4. Appropriately labels the data set with descriptive variable names.
Replacing the variable names of "Result" data frame:

* "BodyBody" replaced by "Body" due to the fact that this is a typo
* "^t" replaced by "Time" and  "^f" replaced by "Freq"  to enhance the descriptivity
* "-mean()" replaced by "Mean" and "-std()" replaced by "Std" becouse "()" is unnecessary character

Writing first tidy data set - "Result.csv" in the Working Directory.

###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
The step requires package "dplyr". 
It creates a data frame contains "ResultMean" with the average of each variable for each activity and each subject.

Writing second tidy data set - "ResultMean.csv" in the Working Directory.

##Variables of data sets
Variable name may include the following substrings:

* Time - time domain signals, indicate signals from the accelerometer and gyroscope 3-axial raw signals 
* Freq - frequency domain signals, Fast Fourier Transform (FFT) was applied, 
* XYZ - is used to denote 3-axial signals in the X, Y and Z directions
* BodyAcc - acceleration signal was then separated into body acceleration signals 
* GravityAcc - acceleration signal was then separated into acceleration signals 
* BodyAccJerk - the body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
* BodyAccMag - the magnitude of these three-dimensional signals were calculated using the Euclidean norm







