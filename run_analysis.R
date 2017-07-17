

#downloading and unzipping the data for the course project

if(!file.exists("./projectdata")) {dir.create("./projectdata")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./projectdata/UCIHARDataset.zip")
unzip("./projectdata/UCIHARDataset.zip", exdir="./projectdata")

#load the activity labels and make them easily readable

activitylabels<-read.table("./projectdata/UCI HAR Dataset/activity_labels.txt")
str(activitylabels)
activitylabels[,2]<-as.character(activitylabels[,2])
activitylabels$V2<-gsub("_", " ", activitylabels$V2)

#load the features 

features<-read.table("./projectdata/UCI HAR Dataset/features.txt")
str(features)
features[,2]<-as.character(features[,2])

#extract only features containing mean and standard deviation

measurements<-grep(".*mean.*|.*std.*", features$V2)
measurements_names<-features[measurements, 2]
measurements_names

#remove unnecessary characters from measurement variables' names and capitalize the sought for Mean and Std

measurements_names<-gsub("-mean", "Mean", measurements_names)
measurements_names<-gsub("-std", "Std", measurements_names)
measurements_names<-gsub("[( )-]", "", measurements_names)
measurements_names<-gsub("^(t)", "time", measurements_names)
measurements_names<-gsub("^(f)", "freq", measurements_names)
measurements_names<-gsub("Acc", "Accelerometer", measurements_names)
measurements_names<-gsub("Gyro", "Gyroscope", measurements_names)
measurements_names<-gsub("Mag", "Magnitude", measurements_names)
measurements_names<-gsub("BodyBody", "Body", measurements_names)

#loading the training data and adding the subjects and labels as columns

train <- read.table("./projectdata/UCI HAR Dataset/train/X_train.txt")[measurements]
trainLabels <- read.table("./projectdata/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("./projectdata/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainLabels, train)

#loading the test data and adding the subjects and labels as columns

test <- read.table("UCI HAR Dataset/test/X_test.txt")[measurements]
testLabels <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testLabels, test)

#merging the datasets into one full set

mydata<-rbind(train, test)
colnames(mydata)<-c("subject", "activity", measurements_names)
mydata$activity<-as.factor(mydata$activity)
levels(mydata$activity)<-c("WALKING", "WALKING UPSTAIRS", "WALKING DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

#creating a new tidy data set with the average of each variable for each activity and each subject

library(reshape2)
mydataMelt <- melt(mydata, id = c("subject", "activity"))
mydataMean <- dcast(mydataMelt, subject + activity ~ variable, mean)

#saving the created data frame

write.table(mydataMean, "./projectdata/TidyAverages.txt", row.names = FALSE, quote = FALSE)

