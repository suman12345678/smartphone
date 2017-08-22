#mobile data#*********************
X_test<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt") 
X_train<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt") activity_labels<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
features<-read.table("C:/Users/suman/Desktop/datasciencecoursera/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt") 
colnames(X_train)<-features[,2]
colnames(X_test)<-features[,2]
colnames(Y_test)<-"activityid"
colnames(Y_train)<-"activityid"
colnames(subject_test)<-"subjectid"
colnames(subject_train)<-"subjectid" 
colnames(activity_labels) <- c('activityid','activitytype')

#merge training n test data 
mergedata<-rbind(cbind(X_train,Y_train,subject_train),cbind(X_test,Y_test,subject_test)) 
colnamesall=colnames(mergedata)  #all cols of merge dataset 

#grep the colnames with id mean and std
meansd<-(grepl("activityid",colnamesall) | grepl("subjectid" , colnamesall) |           grepl("mean.." , colnamesall) |   grepl("std.." , colnamesall)) 

#make subset of columns , from logical vector condition to subset of dataframe columns
finaldata<-mergedata[,meansd==TRUE] 
#join with activityid to get activity name
activityname<-merge(finaldata,activity_labels,by='activityid',all.x=TRUE) 
colnames(activityname) 

#avg of activityname group by activity and subjecttidy
data1<-aggregate(.~subjectid+activityid,activityname,mean)

#write
write.table(data1,"tidy_dataset.txt",row.name=FALSE)