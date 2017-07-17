# __Getting and Cleaning Data Course Project__

This repository contains the documentation and the R code for the final 
Course Project for Coursera's Getting and Cleaning Data Course.

The analysis for the project is based on the following data: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions)

## **Files:**

1. *CodeBook.md*  - contains information about the purpose of the project, 
the data source, collection and description and the files and variables used.
Furthermore, if gives a brief overview of the manipulations of the data
and the final product achieved.

2. *run_analysis.R* - and R file including the code for the project and 
can be read and used to reproduce the analysis by loading it into RStudio.

3. *TidyAverages.txt* - a text document which is the final result of the 
analysis - an independent tidy data set with the average of each variable 
for each activity and each subject.

## **Process of collecting, working with, and cleaning the data set:**

1. The data is downloaded and unzipped
2. The file with the activity labels is loaded and they are made easily readable
3. The features file is loaded, transformed to a character variable and only the variables representing means and standard deviations are extracted
4. The names of the variables are transformed to be more intuitively read and comprehended 
5. The training data is loaded and its components are binded together. Similar actions are performed for the test data
6. The two sets are merged into one and the activity column is transformed into a factor variable to read the actual names of the activities
7. A new tidy data set is created with the average of each variable for each activity and each subject
8. The data set is saved as a new file: *TidyAverages.txt*

