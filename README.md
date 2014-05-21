# Run Analysis README

This file describes what the run_analysis.R script does.

The data is assumed to be in a local folder, UCI HAR Dataset.  The only library used is data.table.  

## 1. Merges the training and the test sets to create one data set.

In this first step we perform the following steps:

* Load the training and testing sets, which include: x_train.txt, y_train.txt, subject_train.txt, x_test.txt, y_test.txt, subject_test.txt
* Next, the code converts the data.frames to data.tables
* The data is combined using rbind

## 1.a. Get the indices for the variables

In the next part we get the indices for the mean and the standard deviation variables.  The variables are determined by using the grepl function and searching for fieldnames names that have exactly mean() or std() in them.  

## 1.b. Get the variable names

This next part of the code performs the following steps:

* Set the mean names,
* Set the standard deviation names, and 
* Put the variable names together.

We determine the variable names by splitting the given field name into substrings using "-" as a delimiter.  We also expand t to Time and f to Freq for frequency. 

## 2. Extracts only the measurements on the mean and standard deviation

The next portion extracts the mean and standard deviation from the data.  The code uses the indices that were found in part 1.a.  The data.table is finished by adding the subject data and activity data.


## 3. Uses descriptive activity names to name the activities in the data set

The active names are taken from the activity labels file. 


## 4. Appropriately label the data set with descriptive activity names. 

The activity flags are replaced with the active names found in part 3.  The code also adds the column names to the variables at this point.  

## 5. Create a tidy data set

second, independent tidy data set with the average of each variable for each activity and each subject. 
# 
unq_sbjs <- sort(unique(data$Subjects))
unq_acts <- sort(unique(data$Activities))
dat_tidy <- as.data.frame(data[1:(length(unq_sbjs)*length(unq_acts)),])
for (i in unq_sbjs)
{
  for (j in 1:length(unq_acts))
  {
    n <- (i-1)*length(unq_acts) + j
    print(n)
    ids    <- ( (data$Subjects==unq_sbjs[i]) &
                (data$Activities==unq_acts[j]) )
    tmpdat <- as.data.frame(data[ids,])
    tmpvec <- colMeans(tmpdat[,3:ncol(tmpdat)])
    
    dat_tidy[n,1] <- unq_sbjs[i]
    dat_tidy[n,2] <- unq_acts[j]
    dat_tidy[n,3:ncol(tmpdat)] <- tmpvec
  }
}

write.csv(dat_tidy,file = "tidy_data.txt")


