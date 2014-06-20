jhsph-GettingandCleaningData
============================

Repository for JHSPH getting and cleaning data module project 

##Details and Program Flow for run_analysis.R

The run_analysis.R file contains a single parameter-less function called run_analysis
which (hopefully) meets all the requirements of the course project for GettingandCleaningData.

Ultimately the code produces a wide format tidy dataset called tidied.txt, please see 
the Hadley Wickham Tiday data paper http://vita.had.co.nz/papers/tidy-data.pdf or the
discussion forum thread on tidy data https://class.coursera.org/getdata-004/forum/thread?thread_id=262 
for a detailed description of how the concepts of wide and tidy are implemented.

#Requirements
The experimental data should be extracted to the current working directory following the same naming 
convention and file structure as in the original zip file

#Program Flow
1: The variable and activity names are imported from features.txt and activity_labels.txt

2.1 The experimental training data, labels and subject information is imported
2.2 The label data is converted to the relevant activity factor 
2.3: A combined dataset of all training information is created

3.1 The experimental test data, labels and subject information is imported
3.2 The label data is converted to the relevant activity factor 
3.3: A combined dataset of all test information is created 

4: A merged dataset is created from the combined test and training datasets using row binding 
This fulfils task 1 of the course project "Merges the training and the test sets to create one data set"

5.1: A dataset is created which only contains  measurements on the mean and standard deviation for each measurement 
This fulfils the requirements for task 2
5.2 However task 5 requires that a dataset on the mean and standard deviation for each measurement by activity and subject is created 
As a result the regex used to generate the dataset at 5.1 is changed to include subject and a second dataset created


6: The variables in the dataset are renamed to make them somewhat easier to read via simple replace calls 
This fulfils the requirements of task 4 "Appropriately labels the data set with descriptive variable names"

7.1: The reshape2 library is loaded to enable dcast function
7.2  A new wide format dataset which contains the average of each variable for each activity and each subject
Since the first two columns of the input dataset are subject and activity these are excluded from the columns to include in the dcast 
7.3 As a result of excluding the first two columns the resultant dataset will end up with the variable column called "3:length(names(sub))"
So this is renamed back to VARIABLE 

8: Finally the complete dataset is saved to disk 
