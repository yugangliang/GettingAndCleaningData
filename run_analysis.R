# read rows of train data
myRow <- read.table("./Data_Folder/train/X_train.txt")
# read columns of train data
myColumn <- read.table("./Data_Folder/train/y_train.txt")
# read subject of train data
mySubject <- read.table("./Data_Folder/train/subject_train.txt")
# read rows of test data
myTestRow <- read.table("./Data_Folder/test/X_test.txt")
# read columns of test data
myTestColumn <- read.table("./Data_Folder/test/y_test.txt") 
# read subject of test data
myTestSubject <- read.table("./Data_Folder/test/subject_test.txt")
# join rows of train and test data
joinedRows <- rbind(myRow, myTestRow)
# join columns for train and test data
joinedColumn <- rbind(myColumn, myTestColumn)
# join subject for train and test data
joinedSubject <- rbind(mySubject, myTestSubject)
# Get subset for mean and standard deviation measurements
myFeatures <- read.table("./Data_Folder/features.txt")
myMeanStandard <- grep("mean\\(\\)|std\\(\\)", myFeatures[, 2])
joinedRows <- joinedRows[, myMeanStandard]
# Clean data with replacing "()" with ""
names(joinedRows) <- gsub("\\(\\)", "", myFeatures[myMeanStandard, 2]) # remove "()"
names(joinedRows) <- gsub("mean", "Mean", names(joinedRows)) # capitalize M
names(joinedRows) <- gsub("std", "Std", names(joinedRows)) # capitalize S
names(joinedRows) <- gsub("-", "", names(joinedRows)) # remove "-" in column names 
# Modify the activities in data set with description names
activity <- read.table("./Data_Folder/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinedColumn[, 1], 2]
joinedColumn[, 1] <- activityLabel
names(joinedColumn) <- "activity"
# modify columns of the data set with descriptive activity names
names(joinedSubject) <- "subject"
mergedData <- cbind(joinedSubject, joinedColumn, joinedRows)
# Create result tidy data set with the average of 
# each variable for each activity and each subject. 
subjectLen <- length(table(joinedSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(mergedData)[2]
resultDataSet <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
resultDataSet <- as.data.frame(resultDataSet)
colnames(resultDataSet) <- colnames(mergedData)
rowCount <- 1
for(i in 1:subjectLen) 
{
    	for(j in 1:activityLen) 
	{
        	resultDataSet[rowCount, 1] <- sort(unique(joinedSubject)[, 1])[i]
        	resultDataSet[rowCount, 2] <- activity[j, 2]
        	bool1 <- i == mergedData$subject
        	bool2 <- activity[j, 2] == mergedData$activity
        	resultDataSet[rowCount, 3:columnLen] <- colMeans(mergedData[bool1&bool2, 3:columnLen])
        	rowCount <- rowCount + 1
    	}
}
#head(resultDataSet) #verify table and data
write.table(resultDataSet, "result_dataset_02_tidy_dataset.txt")

