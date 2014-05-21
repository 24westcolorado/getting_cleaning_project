#----------------------------------------------------------------------------
#
# run_analysis.R
#
#----------------------------------------------------------------------------
# The data is assumed to be in a local folder: UCI HAR Dataset
library(data.table)

#----------------------------------------------------------------------------
#
# 1. Merges the training and the test sets to create one data set.
#
#----------------------------------------------------------------------------
# Load the training and testing data into a data.frame

y_train  <- read.table("UCI HAR Dataset/train/y_train.txt")
X_train  <- read.table("UCI HAR Dataset/train/X_train.txt")
sbjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

y_test   <- read.table("UCI HAR Dataset/test/y_test.txt")
X_test   <- read.table("UCI HAR Dataset/test/X_test.txt")
sbjtest  <- read.table("UCI HAR Dataset/test/subject_test.txt")

#----------------------------------------------------------------------------
# Convert the data to data.table format.  

X_train  <- data.table(X_train)
y_train  <- data.table(Activities = y_train$V1)
sbjtrain <- data.table(Subjects = sbjtrain$V1)

X_test   <- data.table(X_test)
y_test   <- data.table(Activities = y_test$V1)
sbjtest  <- data.table(  Subjects = sbjtest$V1)

#----------------------------------------------------------------------------
# Merge the data (only the testing and traning portion)

X_dat  <- rbind(X_train, X_test )
y_dat  <- rbind(y_train, y_test )
sbjdat <- rbind(sbjtrain, sbjtest )

#----------------------------------------------------------------------------
# Get the indices for the means and standard deviations from the 
# features.txt file

featdat <- read.table("UCI HAR Dataset/features.txt")
featdat <- data.table(featdat)
featdat[,aveid:= { grepl("mean()",V2,fixed=TRUE)}]
featdat[,stdid:= { grepl("std()",V2,fixed=TRUE)}]

mean_ids <- featdat[featdat[,aveid],V1]
std_ids  <- featdat[featdat[,stdid],V1]
ids      <- c(mean_ids, std_ids)

#----------------------------------------------------------------------------
# Get the variable names
# Set the mean names
mean_vars <- as.character(featdat[featdat[,aveid],V2])
for (i in 1:length(mean_vars))
{
  parts <- strsplit(mean_vars[i],"-")
  if (( substr(parts[[1]][1],1,1) == "t") == TRUE)
  {
    type <- "Time"
  } else if (( substr(parts[[1]][1],1,1) == "f") == TRUE)
  {
    type <- "Freq"
  } else
  {
    type <- ""
  }
  if (length(parts[[1]]) == 3)
  {
    dir <- parts[[1]][3]
  } else
  {
    dir <- ""
  }
  mean_vars[i] <- paste(
    "Mean",
    type,
    substr(parts[[1]][1],2,nchar(parts[[1]][1]) ),
    dir,sep="")
}

# Set the standard deviation names
std_vars <- as.character(featdat[featdat[,stdid],V2])
for (i in 1:length(std_vars))
{
  parts <- strsplit(std_vars[i],"-")
  if (( substr(parts[[1]][1],1,1) == "t") == TRUE)
  {
    type <- "Time"
  } else if (( substr(parts[[1]][1],1,1) == "f") == TRUE)
  {
    type <- "Freq"
  } else
  {
    type <- ""
  }
  if (length(parts[[1]]) == 3)
  {
    dir <- parts[[1]][3]
  } else
  {
    dir <- ""
  }
  std_vars[i] <- paste(
    "Std",
    type,
    substr(parts[[1]][1],2,nchar(parts[[1]][1]) ),
    dir,sep="")
}

# Put the variable names together
varnames <- c(
  "Subjects",
  "Activities",
  mean_vars,
  std_vars)

#----------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for
#    each measurement. 

X_dat  <- X_dat[,ids, with = FALSE]

#----------------------------------------------------------------------------
# Merge the Activities and Subjects into the dataset

data <- cbind(sbjdat,y_dat, X_dat)

#----------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data 
#    set

actdat  <- read.table("UCI HAR Dataset/activity_labels.txt")
acttyps <- actdat$V2

#----------------------------------------------------------------------------
# 4. Appropriately label the data set with descriptive activity names. 

data[,Activities:=acttyps[Activities]]
data <- as.data.frame(data)
colnames(data) <- varnames

#----------------------------------------------------------------------------
# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
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


