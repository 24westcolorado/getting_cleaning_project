# README

This repository contains three files:

* run_analysis.R,
* README.md, and 
* CodeBook.md.

Here in the README.md file we describe what the overall package does/describes.  

The CodeBook.md describes the variables, the data that is extracted from a set of raw data, and the transformations that are performed on the raw data.  

The raw data is taken from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data can be found at the following website:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The run_analysis.R performs all the steps in transforming the raw data into a nice tidy dataset.  The run_analysis.R script assumes that the raw data is unzipped and a local folder named 'UCI HAR Dataset' is in the same folder as the script.  The run_analysis.R script produces a text file, in csv format, called tidy_data.txt that contains the cleaned, tidy dataset.  