## This R script:
## 1. Merges the training and the test sets to create one data set. 
## 2. Extracts only the measurements on mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set. 
## 4. Labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for 
##    each activity and each subject.


## Download file and load file
temp<-tempfile()
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,temp)
train_data<-read.table(unz(temp,"UCI HAR Dataset/train/X_train.txt"))
train_subject<-read.table(unz(temp,"UCI HAR Dataset/train/subject_train.txt"))
train_label<-read.table(unz(temp,"UCI HAR Dataset/train/y_train.txt"))

test_data<-read.table(unz(temp,"UCI HAR Dataset/test/X_test.txt"))
test_subject<-read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt"))
test_label<-read.table(unz(temp,"UCI HAR Dataset/test/y_test.txt"))

feature<-read.table(unz(temp,"UCI HAR Dataset/features.txt"))
activity_label<-read.table(unz(temp,"UCI HAR Dataset/activity_labels.txt"))

unlink(temp)

## Merges the training and the test sets to create one data set.
train<-cbind(train_subject,train_label,train_data)
test<<-cbind(test_subject,test_label,test_data)
data<-rbind(train,test)
colnames(data)<-c("Subjects","Activities",as.character(feature$V2))

## Extracts only the measurements on the mean and standard deviation for each measurement.
feature_index<-grep("mean\\(\\)|std\\(\\)",feature$V2)
data_subset<-data[,c(1,2,feature_index+2)]

## Uses descriptive activity names to name the activities in the data set
data_subset$Activities<-factor(data_subset$Activities,levels=activity_label$V1,
                               labels=tolower(activity_label$V2))
data_subset$Subjects<-as.factor(data_subset$Subjects)

## Label the data set with descriptive variable names.
names(data_subset)<-gsub("[()]","",names(data_subset))
names(data_subset)<-gsub("-","_",names(data_subset))
names(data_subset)<-gsub("^t","Time",names(data_subset))
names(data_subset)<-gsub("^f","Frequency",names(data_subset))
names(data_subset)<-gsub("Acc","Acceleration",names(data_subset))
names(data_subset)<-gsub("Gyro","Gyroscope",names(data_subset))
names(data_subset)<-gsub("mean","Mean",names(data_subset))
names(data_subset)<-gsub("std","Std",names(data_subset))

## Creates a second, independent tidy data set with the average of each variable for 
## each activity and each subject.
data_tidy<-aggregate(.~Activities+Subjects,data=data_subset,FUN="mean")
library(dplyr)
data_tidy<-tbl_df(select(data_tidy,Subjects,Activities,everything()))
write.table(data_tidy,"tidydata.txt",row.names=FALSE,quote=FALSE)

