Code Book

This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

1. Read data and Merge
X_test : values of variables in test
X_train : values of variables in train
y_test : activity ID in test
y_train : activity ID in trainsubject_test : subject IDs for test
subject_train : subject IDs for train
activity_labels : Description of activity IDs in y_test and y_train
features : description(label) of each variables in X_test and X_train
X : bind of X_train and X_test
Y : bind of Y_train and Y_test

2. Extract only mean() and std()
Create a vector mean_std_only of only mean and std labels


3. Changing Column label of dataSet
Create a vector of "names(mean_std_only" feature names by getting rid of "()" at the end. Then, will apply that to the dataSet to rename column labels.

4. Appropriately labels the data set with descriptive variable names

5. Rename ID to activity name WITH "tidydata_average_sub"