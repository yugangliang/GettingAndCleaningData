This Code Book describes the variables, the data, and any transformations or work that I performed to clean up the data of which the source is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R does the following operations to get the target data set.

1) reads X_train.txt, y_train.txt and subject_train.txt into myRow, myColumn, and mySubject variables
2) reads X_test.txt, y_test.txt and subject_test.txt into myTestRow, myTestColumn, myTestSubject variables
3) merges and subsets data sets joinedRow, joinedColumns, and joinedSubject
4) reads features.txt file into myFeatures variables
5) extracts only measurements on the mean and standard deviation, and gets a subset of joinedRows accordingly
6) modified column names with string manipulation such as replacing "()" with ""
7) reads activity_labels.txt file into variable activity
8) transforms rows in data fram joinedColumns based on data frame activity
9) merges joinedRows, joinColumns and joinedSubject to a new dataframe variable mergedData
10) gets the target data set with the average value of each measurement of each activity and of each subject
11) writes target data set to data file result_dataset_02_tidy_dataset.txt in root folder



