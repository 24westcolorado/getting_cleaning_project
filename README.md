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

The variable names are given by the following:

* [1] "Subjects"                   
* [2] "Activities"                 
* [3] "MeanTimeBodyAccX"           
* [4] "MeanTimeBodyAccY"           
* [5] "MeanTimeBodyAccZ"           
* [6] "MeanTimeGravityAccX"        
* [7] "MeanTimeGravityAccY"        
* [8] "MeanTimeGravityAccZ"        
* [9] "MeanTimeBodyAccJerkX"       
* [10] "MeanTimeBodyAccJerkY"       
* [11] "MeanTimeBodyAccJerkZ"       
* [12] "MeanTimeBodyGyroX"          
* [13] "MeanTimeBodyGyroY"          
* [14] "MeanTimeBodyGyroZ"          
* [15] "MeanTimeBodyGyroJerkX"      
* [16] "MeanTimeBodyGyroJerkY"      
* [17] "MeanTimeBodyGyroJerkZ"      
* [18] "MeanTimeBodyAccMag"         
* [19] "MeanTimeGravityAccMag"      
* [20] "MeanTimeBodyAccJerkMag"     
* [21] "MeanTimeBodyGyroMag"        
* [22] "MeanTimeBodyGyroJerkMag"    
* [23] "MeanFreqBodyAccX"           
* [24] "MeanFreqBodyAccY"           
* [25] "MeanFreqBodyAccZ"           
* [26] "MeanFreqBodyAccJerkX"       
* [27] "MeanFreqBodyAccJerkY"       
* [28] "MeanFreqBodyAccJerkZ"       
* [29] "MeanFreqBodyGyroX"          
* [30] "MeanFreqBodyGyroY"          
* [31] "MeanFreqBodyGyroZ"          
* [32] "MeanFreqBodyAccMag"         
* [33] "MeanFreqBodyBodyAccJerkMag" 
* [34] "MeanFreqBodyBodyGyroMag"    
* [35] "MeanFreqBodyBodyGyroJerkMag"
* [36] "StdTimeBodyAccX"            
* [37] "StdTimeBodyAccY"            
* [38] "StdTimeBodyAccZ"            
* [39] "StdTimeGravityAccX"         
* [40] "StdTimeGravityAccY"         
* [41] "StdTimeGravityAccZ"         
* [42] "StdTimeBodyAccJerkX"        
* [43] "StdTimeBodyAccJerkY"        
* [44] "StdTimeBodyAccJerkZ"        
* [45] "StdTimeBodyGyroX"           
* [46] "StdTimeBodyGyroY"           
* [47] "StdTimeBodyGyroZ"           
* [48] "StdTimeBodyGyroJerkX"       
* [49] "StdTimeBodyGyroJerkY"       
* [50] "StdTimeBodyGyroJerkZ"       
* [51] "StdTimeBodyAccMag"          
* [52] "StdTimeGravityAccMag"       
* [53] "StdTimeBodyAccJerkMag"      
* [54] "StdTimeBodyGyroMag"         
* [55] "StdTimeBodyGyroJerkMag"     
* [56] "StdFreqBodyAccX"            
* [57] "StdFreqBodyAccY"            
* [58] "StdFreqBodyAccZ"            
* [59] "StdFreqBodyAccJerkX"        
* [60] "StdFreqBodyAccJerkY"        
* [61] "StdFreqBodyAccJerkZ"        
* [62] "StdFreqBodyGyroX"           
* [63] "StdFreqBodyGyroY"           
* [64] "StdFreqBodyGyroZ"           
* [65] "StdFreqBodyAccMag"          
* [66] "StdFreqBodyBodyAccJerkMag"  
* [67] "StdFreqBodyBodyGyroMag"     
* [68] "StdFreqBodyBodyGyroJerkMag" 


## 2. Extracts only the measurements on the mean and standard deviation

The next portion extracts the mean and standard deviation from the data.  The code uses the indices that were found in part 1.a.  The data.table is finished by adding the subject data and activity data.


## 3. Uses descriptive activity names to name the activities in the data set

The active names are taken from the activity labels file. 


## 4. Appropriately label the data set with descriptive activity names. 

The activity flags are replaced with the active names found in part 3.  The code also adds the column names to the variables at this point.  

## 5. Create a tidy data set

In this step the code constructs a tidy data set from the previous data set just created.  The first two columns of the tidy data set are the Subjects and the Activities.  The following columns are the average values of the variables over each each activity and each subject. 

The performs the following steps:

* Find the unique Subjects and Activities
* Loop through the Subjects and Activities
* For each pair the code finds the corresponding rows,  then calculates the means for all the variables, and records the data

After the loop is completed the data is written to a txt file, in a csv format, called tidy_data.txt.