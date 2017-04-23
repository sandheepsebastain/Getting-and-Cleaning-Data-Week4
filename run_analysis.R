#Reading in the train set
dfTrain<-read.table("UCI HAR Dataset/train/X_train.txt")
#Get 561 feature header names
dfFeature<-read.table("UCI HAR Dataset/features.txt")
names(dfFeature)<-c("featuresid","features")
names(dfTrain)<-dfFeature$features
dfTrainActivity<-read.table("UCI HAR Dataset/train/y_train.txt")
names(dfTrainActivity)<-"activityid"
dfTrainSubject<-read.table("UCI HAR Dataset/train/subject_train.txt")
names(dfTrainSubject)<-"subjectid"
#merging all the 3 to get a complete training set
dfTrain<-cbind(dfTrainSubject,dfTrainActivity,dfTrain)
dfTrain["datasettype"]<-"train"


#Reading in the test set
dfTest<-read.table("UCI HAR Dataset/test/X_test.txt")
names(dfTest)<-dfFeature$features
dfTestActivity<-read.table("UCI HAR Dataset/test/y_test.txt")
names(dfTestActivity)<-"activityid"
dfTestSubject<-read.table("UCI HAR Dataset/test/subject_test.txt")
names(dfTestSubject)<-"subjectid"
#merging all the 3 to get a complete training set
dfTest<-cbind(dfTestSubject,dfTestActivity,dfTest)
dfTest["datasettype"]<-"test"


#Combining datasets
dfCombine<-rbind(dfTrain,dfTest)
cSelCol<-grep("mean\\(\\)|std",names(dfCombine),value=TRUE)
cDefaultCols<-c("subjectid","activityid","datasettype")
cAllCol<-c(cDefaultCols,cSelCol)
dfCombineTidy<-dfCombine[,cAllCol]

#Reading Activity Dataset
dfActivityLabels<-read.table("UCI HAR Dataset/activity_labels.txt")
names(dfActivityLabels)<-c("activityid","activity")

#merging Activity label
dfCombineTidy<-merge(x=dfCombineTidy,y=dfActivityLabels,by="activityid",all.x = TRUE)
cDefaultCols<-c("subjectid","activityid","activity","datasettype")
cAllCol<-c(cDefaultCols,cSelCol)
dfCombineTidy<-dfCombineTidy[,cAllCol]

#Transform column names
cColNamesTransform<-sub("t+(?:Body)+Acc","Time Domain-Body-Accelerometer-",names(dfCombineTidy))
cColNamesTransform<-sub("t+(?:Gravity)+Acc","Time Domain-Gravity-Accelerometer-",cColNamesTransform)
cColNamesTransform<-sub("t+(?:Body)+Gyro","Time Domain-Body-Gyroscope-",cColNamesTransform)
cColNamesTransform<-sub("t+(?:Gravity)+Gyro","Time Domain-Gravity-Gyroscope-",cColNamesTransform)

cColNamesTransform<-sub("f+(?:Body)+Acc","Fourier Transform-Body-Accelerometer-",cColNamesTransform)
cColNamesTransform<-sub("f+(?:Gravity)+Acc","Fourier Transform-Gravity-Accelerometer-",cColNamesTransform)
cColNamesTransform<-sub("f+(?:Body)+Gyro","Fourier Transform-Body-Gyroscope-",cColNamesTransform)
cColNamesTransform<-sub("f+(?:Gravity)+Gyro","Fourier Transform-Gravity-Gyroscope-",cColNamesTransform)

names(dfCombineTidy)<-cColNamesTransform

#Getting average of each variable, by each subject, by each activity
library(dplyr)
cColsToDelete<-c("activityid","datasettype")

dfAvgTidy<-dfCombineTidy[,!(names(dfCombineTidy) %in% cColsToDelete)]


dfAvgTidy<-dfAvgTidy %>%
              group_by(subjectid,activity) %>%
              summarise_each(funs(mean))


dfAvgTidy
