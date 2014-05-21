
# CodeBook

This file describes the variables, the data, and transformations that were performed.  We discuss the following:

* The variable names,
* The two data frames that the script runanalysis.R constructs, and
* The steps that are taken in the run_analysis.R script, which describes all the transformations that were performed.  

## Variable Names

In this section we describe the variable names.  There are a total of 68 variables, which are made up of 2 test parameters and 66 measurements.  The first two variables refer to the Subject number and the Activity type.  The remaining variables are values derived from the Samsung accelerometer.  

Further details about the raw data set, which help describe the variables can be found at:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The 66 measurement variables follow a particular form:

[Mean/Std][Time/Freq][Measurment Type][X/Y/Z if applicable]

The parts are described by the following:

1. Either Mean or Std (which stands for standard deviation) of the measurement.  
2. Time or Freq (Frequency) domain of the measurement.
3.  Specific measurement type, explained in the table below.
4.  X, Y, or Z direction of the measurement when applicable. 

The first two variables and the specific measurement types are described below:

| Variables  			| Description 	|
| :--------- 			|  ---------: 	| 
| Subjects   			| Number of the subject (1,2,...30)			 	|
| Activities 			| Activity type: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 					|
| BodyAcc 				| Body Acceleration	 |	
| GravityAcc 			| Gravity Acceleration |
| BodyAccJerk 			| Body Jerk (deriv of Acc) |
| BodyGyro 				| Body Gyro measurement |
| BodyGyroJerk 			| Body Jerk meassurement of the Gyro |
| BodyAccMag			| Body Acceleration magnitude |
| GravityAccMag			| Magnitude of Gravity |
| BodyAccJerkMag 		| Magnitude of the Body Jerk Measurement |
| BodyGyroMag 			| Magnitude of the Body Gyro Measurement |
| BodyGyroJerkMag		| Magnitude of Jerk of the Body Gyro measurement |     
| BodyBodyAccJerkMag 	| ?Body of the Body measurement of the magnitude of the Jerk |
| BodyBodyGyroMag 	 	| ?Body of the Body measurement of the magnitude of the Gyro |
| BodyBodyGyroJerkMag  	| ?Body of the Body measurement of the magnitude of the Jerk of the Gyro |

## Data Frame Descriptions

There are two data frames produced by the run_analysis.R script, data and data_tidy. Both data frames have the same number of columns, 68.  Each column corresponds to the variables described above, and listed at the bottom of this file.

The first data frame, data, contains all samples.  That is, for a given Subject and Activity there are more than one set of measuremnts.  There are a total of 10,299 rows in this dataset.  

The second data frame, data_tidy, contains the average of all the measurements for each Subject and Activity combination.  That is, for each unique pair of Subject and Activity there is one average value for the remaining 66 variables.  There are 30 Subjects and 6 activities, so data_tidy has 180 rows.  Furthermore, data_tidy is saved into a text file, in csv format, at the end of the script.  

## Steps performed in run_analysis.R

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

In this step the code constructs a tidy data set from the previous data set just created.  The first two columns of the tidy data set are the Subjects and the Activities.  The following columns are the average values of the variables over each each activity and each subject. 

The performs the following steps:

* Find the unique Subjects and Activities
* Loop through the Subjects and Activities
* For each pair the code finds the corresponding rows,  then calculates the means for all the variables, and records the data

After the loop is completed the data is written to a txt file, in a csv format, called tidy_data.txt.

# Overall List of Variables


| Variables  			| 
| :--------- 			| 
| Subjects   			| 
| Activities 			| 
| MeanTimeBodyAccX 		| 
| MeanTimeBodyAccY 		| 
| MeanTimeBodyAccZ 		| 
| MeanTimeGravityAccX 	| 
| MeanTimeGravityAccY 	| 
| MeanTimeGravityAccZ 	| 
| MeanTimeBodyAccJerkX 	| 
| MeanTimeBodyAccJerkY	| 
| MeanTimeBodyAccJerkZ 	|
| MeanTimeBodyGyroX 	|
| MeanTimeBodyGyroY 	|
| MeanTimeBodyGyroZ 	|
| MeanTimeBodyGyroJerkX 	|     
| MeanTimeBodyGyroJerkY		|
| MeanTimeBodyGyroJerkZ		|
| MeanTimeBodyAccMag		|
| MeanTimeGravityAccMag		|  
| MeanTimeBodyAccJerkMag 	|  
| MeanTimeBodyGyroMag 		|
| MeanTimeBodyGyroJerkMag	|    
| MeanFreqBodyAccX			|           
| MeanFreqBodyAccY			|
| MeanFreqBodyAccZ 			|
| MeanFreqBodyAccJerkX 		|
| MeanFreqBodyAccJerkY		|
| MeanFreqBodyAccJerkZ		|
| MeanFreqBodyGyroX			|
| MeanFreqBodyGyroY 		|
| MeanFreqBodyGyroZ 		|
| MeanFreqBodyAccMag		|
| MeanFreqBodyBodyAccJerkMag | 
| MeanFreqBodyBodyGyroMag 	|    
| MeanFreqBodyBodyGyroJerkMag |
| StdTimeBodyAccX 			|            
| StdTimeBodyAccY 			|
| StdTimeBodyAccZ 			|
| StdTimeGravityAccX 		|  
| StdTimeGravityAccY 		|  
| StdTimeGravityAccZ 		|   
| StdTimeBodyAccJerkX 		|  
| StdTimeBodyAccJerkY 		|  
| StdTimeBodyAccJerkZ 		|  
| StdTimeBodyGyroX 			|  
| StdTimeBodyGyroY 			|  
| StdTimeBodyGyroZ 			|  
| StdTimeBodyGyroJerkX 		|  
| StdTimeBodyGyroJerkY 		|  
| StdTimeBodyGyroJerkZ 		|  
| StdTimeBodyAccMag 		|  
| StdTimeGravityAccMag 		|  
| StdTimeBodyAccJerkMag 	|  
| StdTimeBodyGyroMag		|  
| StdTimeBodyGyroJerkMag	|  
| StdFreqBodyAccX 			|  
| StdFreqBodyAccY			|  
| StdFreqBodyAccZ 			|  
| StdFreqBodyAccJerkX		|  
| StdFreqBodyAccJerkY 		|  
| StdFreqBodyAccJerkZ		|  
| StdFreqBodyGyroX			|  
| StdFreqBodyGyroY			|  
| StdFreqBodyGyroZ			|  
| StdFreqBodyAccMag			|  
| StdFreqBodyBodyAccJerkMag |  
| StdFreqBodyBodyGyroMag 	| 
| StdFreqBodyBodyGyroJerkMag |
