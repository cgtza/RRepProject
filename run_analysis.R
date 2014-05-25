# This script attempts to answer the course project for Getting and Cleaning Data

# It does the following
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each variable for each activity 
# and each subject. 

# Read in test data set files and name the vars


X_test<-read.table("X_test.txt")
feature_names<-read.table("features.txt")
names(X_test)<-feature_names$V2

subject_test<-read.table("subject_test.txt")
names(subject_test)[1]<-"Subject"

y_test<-read.table("y_test.txt")
names(y_test)[1]<-"activity"

y_test$activity<-mapvalues(y_test$activity, 
                           c(1,2,3,4,5,6),to= c("walking","walking_upstairs",
                           "walking_downstairs","sitting","standing","laying"), warn_missing=T)
y_test$activity<-as.factor(y_test$activity)


# Combine the subject names, activities, and data

testdata<-cbind(subject_test,y_test,X_test)



# create a variable that reflects that all these data are from the test set

testdata$source<-rep("test_data",length(testdata$Subject))



# Read in training data set files and name the vars

X_train<-read.table("X_train.txt")
feature_names<-read.table("features.txt")
names(X_train)<-feature_names$V2

subject_train<-read.table("subject_train.txt")
names(subject_train)[1]<-"Subject"

y_train<-read.table("y_train.txt")
names(y_train)[1]<-"activity"

y_train$activity<-mapvalues(y_train$activity, c(1,2,3,4,5,6),
                            to= c("walking","walking_upstairs",
                            "walking_downstairs","sitting","standing","laying"), warn_missing=T)
y_train$activity<-as.factor(y_train$activity)



# Combine the subject names, activities, and data

traindata<-cbind(subject_train,y_train,X_train)

# create a variable that reflects that all these data are from the training set
traindata$source<-rep("train_data",length(traindata$Subject))



# Combine the training and test data sets

activity_data<-rbind(traindata,testdata)

# Now we have to keep only variables that reflect computations of mean and sd
# We may need to subset by column, using a character match expression in variable name

library("plyr")
library("reshape")

pattern<-c("mean|std")
df<-activity_data[,(grep(pattern,names(activity_data)))]
sel_activity_data<-cbind(activity_data$Subject,activity_data$source,activity_data$activity,df)

colnames(sel_activity_data)[1] <- "Subject"
colnames(sel_activity_data)[2] <- "source"
colnames(sel_activity_data)[3] <- "activity"




molten_data<-melt(sel_activity_data, id=c("Subject", "source","activity"))
a<-cast(molten_data, Subject+activity~variable, mean)
b<-cast(molten_data, Subject~variable+activity, mean)

write.table(b,file="Activity_data_per_activity_and_subject.txt",col.names=T,row.names=F,na="NA",sep=",",qmethod = "double")

