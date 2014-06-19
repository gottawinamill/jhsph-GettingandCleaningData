## JV 2014-06-19  
run_analysis <- function(){

	#import variable names & activities
	features <- read.table("./UCI HAR Dataset/features.txt")
	variables <- features[,2]

	activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
	acts <- activitylabels[,2]

	#free up some memory
	features <- NULL
	activitylabels <- NULL

	#import training data (X), labels (y) and subject
	train_x <- read.table("./UCI HAR Dataset/train/x_train.txt",
	colClasses=rep("numeric",561), col.names=variables)

	train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
	train_y <- factor(train_y[[1]], levels=1:6, labels=acts)
	train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")

	# create combined 
	trainCombi <- cbind(train_subject,"activity"=train_y , train_x)
	

	#import test data (X), labels (y) and subject
	test_x <- read.table("./UCI HAR Dataset/test/x_test.txt",
	colClasses=rep("numeric",561), col.names=variables)

	test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
	test_y <- factor(test_y[[1]], levels=1:6, labels=acts)

	test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")
	testCombi <- cbind(test_subject, "activity"=test_y, test_x)

	#TASK 1: Create a merged dataset
		# from readme.txt "70% of the volunteers was selected for generating the training data 
		#		and 30% the test data." so this has to be an rbind merge 
	mergeData <- rbind(trainCombi, testCombi)

	#TASK 2: Create dataset which only contains  measurements on the 
		#mean and standard deviation for each measurement
		# we need to create two datasets here one which fulfils the exact requirements of the task
		# and since task 5 requires the subject a 2nd ds with the subject also included

	colsRequired <- "activity|mean|std"
	taskDs <- mergeData[,grep(colsRequired,names(mergeData),ignore.case=TRUE)] # task dataset
	
	colsRequired <- "activity|subject|mean|std"
	sub <- mergeData[,grep(colsRequired, names(mergeData), ignore.case=TRUE)]


	#TASK 3: Use descriptive activity names to name the activities in the data set - 
		# already completed as part of the import of y_train and y_test

	#TASK 4: Appropriately labels the data set with descriptive variable names

	# rename to make the variables somewhat easier to understand and read 
	names(sub) <- gsub("\\.\\.\\.", "_", names(sub))
	names(sub) <- gsub("\\.\\.", "_", names(sub))
	names(sub) <- gsub("\\.", "_", names(sub))
	names(sub) <- gsub("_", "", names(sub))
	names(sub) <- gsub("\\(\\)", "", names(sub))



	#TASK 5: Creates a second, independent tidy data set 
		# with the average of each variable for each activity and each subject

	library(reshape2)
	tidied <- dcast(sub, names(sub)[3:length(names(sub))] ~ activity + subject, mean)
	names(tidied)[1] <- "VARIABLE"
		
	write.table(x=tidied,file="tidied.txt",row.names=F, sep=",")





}