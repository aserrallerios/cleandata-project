setwd("~/courses/r-course");

library("data.table");
library("plyr");

activities<-read.csv('UCI HAR Dataset/activity_labels.txt', sep = ' ', header = FALSE);
subjectsTest<-read.csv('UCI HAR Dataset/test/subject_test.txt', header = FALSE);
subjectsTrain<-read.csv('UCI HAR Dataset/train/subject_train.txt', header = FALSE);

activitiesTest<-read.csv('UCI HAR Dataset/test/y_test.txt', header = FALSE);
activitiesTrain<-read.csv('UCI HAR Dataset/train/y_train.txt', header = FALSE);

activitiesTest<-merge(activitiesTest, activities)[,2];
activitiesTrain<-merge(activitiesTrain, activities)[,2];

test<-data.frame(subjectsTest,activitiesTest);
train<-data.frame(subjectsTrain,activitiesTrain);

names(test)<-c("Subject", "Activity");
names(train)<-c("Subject", "Activity");

features<-read.csv('UCI HAR Dataset/features.txt', sep = ' ', header = FALSE);

dataTest<-read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE);
dataTrain<-read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE);

dataTestMnSd<-dataTest[,grep(x = features$V2, pattern = "*mean*|*std*", ignore.case = TRUE)];
dataTrainMnSd<-dataTrain[,grep(x = features$V2, pattern = "*mean*|*std*", ignore.case = TRUE)];

names(dataTestMnSd)<-features[grep(x = features$V2, pattern = "*mean*|*std*", ignore.case = TRUE),"V2"];
names(dataTrainMnSd)<-features[grep(x = features$V2, pattern = "*mean*|*std*", ignore.case = TRUE),"V2"];

test<-data.frame(test,dataTestMnSd);
train<-data.frame(train,dataTrainMnSd);

dataset<-rbind(train, test);

datatable<-data.table(dataset);

result<-as.data.frame(datatable[, lapply(.SD, mean), by = c("Subject","Activity")]);

result<-arrange(result, Subject, Activity);

write.table(result, file = 'UCI HAR Dataset/tidydata.txt', row.name = FALSE);
