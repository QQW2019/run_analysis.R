#Project gOAL: Create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Prepare
#download data and set working directory
#get working directory
getwd()
filesPath <- "C:/Users/QW/Data of Science/course 3 Getting and Cleaning data/week 4/PROJECT/UCI HAR Dataset"

#check required packages
library(dplyr)
library(data.table)

#read data with assigned variables
featureNames <- read.table("features.txt")
activity_labels <- read.table("./activity_labels.txt", col.names = c("code", "activity"))

#read files
y_test <- read.table("./test/y_test.txt", col.names = "code")
y_train <- read.table("./train/y_train.txt", col.names = "code")
X_train <- read.table("./train/X_train.txt", col.names = features$functions)
x_test <- read.table("./test/X_test.txt", col.names = features$functions)

#add column names for measurement files
names(X_train) <- featureNames$V2
names(X_test) <- featureNames$V2

#add column name for label files
names(y_train) <- "activity"
names(y_test) <- "activity"

#read subject files
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
subject_train <-read.table("./train/subject_train.txt", col.names = "subject")

# add column name for subject files
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

# step1.merges data and create one data set
X <- rbind(X_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_test, subject_train)
Merged_Data <- cbind(Subject, Y, X)

#step2.Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_only <- Merged_Data[,grepl("mean|std", names(Merged_Data))]
mean_std_only[1:2] <- TRUE

#step3. Uses descriptive activity names to name the activities in the data set
names(mean_std_only) <- gsub("\\(|\\)", "", names(mean_std_only), perl  = TRUE)
names(mean_std_only) <- make.names(c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"), unique = FALSE, allow_ = TRUE)

#step4.Appropriately labels the data set with descriptive variable names.
names(mean_std_only)<-gsub("Acc", "Accelerometer", names(mean_std_only))
names(mean_std_only)<-gsub("Gyro", "Gyroscope", names(mean_std_only))
names(mean_std_only)<-gsub("BodyBody", "Body", names(mean_std_only))
names(mean_std_only)<-gsub("Mag", "Magnitude", names(mean_std_only))
names(mean_std_only)<-gsub("^t", "Time", names(mean_std_only))
names(mean_std_only)<-gsub("^f", "Frequency", names(mean_std_only))
names(mean_std_only)<-gsub("tBody", "TimeBody", names(mean_std_only))
names(mean_std_only)<-gsub("-mean()", "Mean", names(mean_std_only), ignore.case = TRUE)
names(mean_std_only)<-gsub("-std()", "STD", names(mean_std_only), ignore.case = TRUE)
names(mean_std_only)<-gsub("-freq()", "Frequency", names(mean_std_only), ignore.case = TRUE)
names(mean_std_only)<-gsub("angle", "Angle", names(mean_std_only))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

#step5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata_average_sub<- ddply(mean_std_only, c("subject","activity"), numcolwise(mean))
write.table(tidydata_average_sub,file="tidydata.txt")
