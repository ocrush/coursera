# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
# Adds descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive activity names. 
# Creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.

# Assumes that the data is already downloaded and the script is executed from
# data directory.

# dir = "C:\\Jasmit\\education\\classes\\datascience_track\\getting and cleaning data\\project\\UCI HAR Dataset"
# read meta-data information

features <- read.table("features.txt")
# retreive all indices for variables that have mean or std deviation 
idx <- c(grep("-mean()",features$V2,fixed=TRUE), grep("-std()",features$V2,fixed=TRUE))
# get the labels for each activity
aLabels <-    read.table("activity_labels.txt")

#subjects from training and add training codes
trainData <- cbind(read.table(paste("train",.Platform$file.sep,"subject_train.txt",sep="")),
            activity_code= read.table(paste("train",.Platform$file.sep,"y_train.txt",sep="")))
# test data
testData <- cbind(read.table(paste("test",.Platform$file.sep,"subject_test.txt",sep="")),
                  activity_code= read.table(paste("test",.Platform$file.sep,"y_test.txt",sep="")))

colnames(trainData) <- c("subject","activity_code")
colnames(testData) <- c("subject","activity_code")

# descriptive information for each training code.
trainData <- cbind(trainData,activity=factor(trainData$activity_code,labels=aLabels$V2))
testData <- cbind(testData,activity=factor(testData$activity_code,labels=aLabels$V2))

# measurements for train data
#TODO: Is it possible to make the reading any faster
data <- (read.table(paste("train",.Platform$file.sep,"X_train.txt",sep="")))[,idx]
colnames(data) <- features$V2[idx]
trainData <- cbind(trainData,data)

#measurements for test data
data <- (read.table(paste("test",.Platform$file.sep,"X_test.txt",sep="")))[,idx]
colnames(data) <- features$V2[idx]
testData <- cbind(testData,data)

rm(data)
rm(features)
rm(aLabels)
#merge train and test data
mergeData <- merge(trainData,testData,all=TRUE)

rm(trainData)
rm(testData)

require(reshape2)
#sapply(split(d[,4:ncol(d)],list(d$subject,d$activity_code)),colMeans)
#group data
tidyDataMelt <- melt(mergeData,id=c("subject","activity"),
                     measured=names(mergeData[,4:ncol(d)]))
#reshape and summarize
tidyData <- dcast(tidyDataMelt,subject + activity ~ variable,mean)

rm(tidyDataMelt)
#write.table(tidyData,file="tidyData.txt")