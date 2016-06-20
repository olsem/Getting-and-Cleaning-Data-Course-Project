
#Read data set.
#Before reading the data should be unzipped to the data directory "UCI HAR Dataset" and the data directory must be placed in the the Working Directory.
#Data is written to a temporary data frames.
#Results of the script - files "Result.csv" and "ResultMean.csv" in the Working Directory. The files contain tidy data sets.

X_test<-read.table("UCI HAR Dataset\\test\\X_test.txt",quote="",header=FALSE)
X_train<-read.table("UCI HAR Dataset\\train\\X_train.txt",quote="",header=FALSE)
features<-read.table("UCI HAR Dataset\\features.txt",quote="",header=FALSE,stringsAsFactors=FALSE)                  
y_test<-read.table("UCI HAR Dataset\\test\\y_test.txt",quote="",header=FALSE,col.names="activity")
y_train<-read.table("UCI HAR Dataset\\train\\y_train.txt",quote="",header=FALSE,col.names="activity")
subject_test<-read.table("UCI HAR Dataset\\test\\subject_test.txt",quote="",header=FALSE,col.names="subject")
subject_train<-read.table("UCI HAR Dataset\\train\\subject_train.txt",quote="",header=FALSE,col.names="subject")
activity<-read.table("UCI HAR Dataset\\activity_labels.txt",quote="",header=FALSE,stringsAsFactors=FALSE)   

#1. Merges the training and the test sets to create one data set.

X<-rbind(X_test,X_train)
names(X)<-features[,2]

y<-rbind(y_test,y_train)

subject<-rbind(subject_test,subject_train)

Result<-cbind(y,subject,X)

#Removal of unnecessary data frames
rm(list=c("X_test","X_train","y_test","y_train","subject_test","subject_train","subject","y","X"))

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Extracts only the measurements including lines "mean(" and "std(".

g<-grep("mean[(]|std[(]",features[,2])    
Result<-Result[,c(1:2,g+2)]  

#Removal of unnecessary vector
rm(list=c("g","features"))

#3. Uses descriptive activity names to name the activities in the data set     
Result$activity<-activity[Result$activity,2]  

#Removal of unnecessary data frames
rm(activity)

#4. Appropriately labels the data set with descriptive variable names.
n<-names(Result)                           
n<-gsub("BodyBody","Body",n)
n<-gsub("^t","Time",n)
n<-gsub("^f","Freq",n)
n<-gsub("-mean()","Mean",n,fixed=T)
n<-gsub("-std()","Std",n,fixed=T)
n<-gsub("-","",n,fixed=T)
names(Result)<-n
rm(n)

#result is writing into R Working Directory
write.csv(Result,"Result.csv",row.names = FALSE)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)

ResultMean<-tbl_df(Result)
ResultMean<- ResultMean %>% group_by(activity,subject) %>% summarize_each("mean")

#result is writing R Working Directory
write.csv(ResultMean,"ResultMean.csv",row.names = FALSE)
