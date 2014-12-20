####################################################################
## Script for the coursera Getting and Cleaning Data course project
## Author: Stephanie Boue
## Date: 20th december 2014
####################################################################
library(plyr)
library(reshape2)


setwd("C:/Users/Steph/Documents/Coursera_Data_science/Course3_Get_and_Clean_Data/Course_project")
if(!file.exists("./data")){dir.create("./data")}

#### Download and unzip file
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/data.zip")
unzip("./data/data.zip",exdir = "data")

## The folder extracted is called "UCI HAR Dataset"; it contains text files and 2 folders: train and test
## which each contain a few text files, and a folder called "Inertial Signals"


train_folder<-c("./data/UCI HAR Dataset/train")
test_folder<-c("./data/UCI HAR Dataset/test")

### Understanding the data
readLines(paste(train_folder,"X_train.txt",sep="/"),1)
readLines(paste(train_folder,"y_train.txt",sep="/"),10)
readLines(paste(train_folder,"subject_train.txt",sep="/"),10)

##############################################################################################################################
### STEP 1 - Merges the training and the test sets to create one data set.
##############################################################################################################################
  
  Xtrain<-read.table(paste(train_folder,"X_train.txt",sep="/"),sep="",header=FALSE)
  ## dim(Xtrain) 7352 x 561
  
  ytrain<-read.table(paste(train_folder,"y_train.txt",sep="/"),sep="",header=FALSE)
  ## dim(ytrain) 7352 x 1
  ## summary(ytrain)  -> numbers 1 to 6 correspond to the activities
  act_train<-ytrain$V1
  
  subject_train<-read.table(paste(train_folder,"subject_train.txt",sep="/"),sep="",header=FALSE,stringsAsFactors=FALSE)
  subject_train<-subject_train$V1
  ## dim(subject_train) 7352 x 1
  
  my_table_train<-cbind(subject=subject_train,activity=act_train,Xtrain)
  ## head(my_table)
  
  
  Xtest<-read.table(paste(test_folder,"X_test.txt",sep="/"),sep="",header=FALSE)
  
  ytest<-read.table(paste(test_folder,"y_test.txt",sep="/"),sep="\t",header=FALSE)
  act_test<-ytest$V1
  
  subject_test<-read.table(paste(test_folder,"subject_test.txt",sep="/"),sep="\t",header=FALSE)
  subject_test<-subject_test$V1
  
  my_table_test<-cbind(subject=subject_test,activity=act_test,Xtest)
  
  ## dim(my_table_train) 7352 x 563
  ## dim(my_table_test) 2947 x 563
  
  ### merge the training and test sets to create one data set
  my_table<-rbind(my_table_train,my_table_test)
  

##############################################################################################################################
### STEP 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 
##############################################################################################################################
  
  features<-read.table("./data/UCI HAR Dataset/features.txt",sep="",header=FALSE)
  features<-features$V2
  index_mean<-grep("-mean()",features,fixed=TRUE)
  index_std<-grep("-std()",features,fixed=TRUE)
  to_keep_my_table<-union(index_mean,index_std)+2 ### adds 2 because I have 2 columns before the variables in my table
  to_keep_names<-union(index_mean,index_std) 
  names_var_to_keep<-features[to_keep_names]
  
  my_table_filtered<-my_table[,c(1,2,to_keep_my_table)]

##############################################################################################################################
### STEP 3 - Uses descriptive activity names to name the activities in the data set 
##############################################################################################################################
  
  activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
  activity_labels<-activity_labels$V2
  activity_labels<-as.factor(gsub("_",".",activity_labels))
  
  act_train<-as.factor(my_table_filtered$activity)
  
  for (i in 1:6)
  {
    levels(act_train)[levels(act_train)==i]<-levels(activity_labels)[i]
  }

  my_table_filtered$activity_name<-act_train

##############################################################################################################################
### STEP 4 - Appropriately labels the data set with descriptive variable names.  
##############################################################################################################################

  colnames(my_table_filtered)<-c("subject","activity",as.character(names_var_to_keep),"activity_name")

##############################################################################################################################
### STEP 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
###           for each activity and each subject.
##############################################################################################################################

  my_table_filtered$act_subj<-paste(my_table_filtered$activity_name,my_table$subject,sep="_")

  step5<-matrix(0,nrow=length(unique(my_table_filtered$act_subj)),ncol=length(names_var_to_keep))
  colnames(step5)<-as.character(names_var_to_keep)
  
  for (i in 1:length(names_var_to_keep))
  {
    data<-my_table_filtered[,c(1,2,i+2,69,70)]
    colnames(data)[3]<-c("measure")
    step5[,i]<- tapply(data$measure,data$act_subj,mean)
    
  }

  ordered_row_values<-unlist(dimnames(tapply(data$measure,data$act_subj,mean)))
  
  step5<-cbind(subject=c(sapply(strsplit(ordered_row_values,"_"),`[`, 2)),activity=c(sapply(strsplit(ordered_row_values,"_"),`[`, 1)),step5)
  
  write.table(step5,"step5.txt",sep="\t",row.names=FALSE)





