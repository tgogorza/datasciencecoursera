library(dplyr)
source("cleanfeaturenames.R")
source("get_averages.R")

#Load Datasets
#loaddata()
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
featurestrain <- read.table("UCI HAR Dataset/train/X_train.txt")
labelstrain <- read.table("UCI HAR Dataset/train/Y_train.txt")

#Test Data
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt")
featurestest <- read.table("UCI HAR Dataset/test/X_test.txt")
labelstest <- read.table("UCI HAR Dataset/test/Y_test.txt")

#Load Feature names
featurenames <- read.table("UCI HAR Dataset/features.txt")

#Step 1: Merge data sets
#Merge Data
subjects <- rbind(subjtrain,subjtest)
features <- rbind(featurestrain,featurestest)
labels <- rbind(labelstrain,labelstest)

#Set column names
names(features) <- featurenames[[2]]
names(subjects) <- c("subject")
names(labels) <- c("activity")

#Step 2: Extract mean and std from each measurement
meancolumns <- grep("-mean()",featurenames[[2]],value=FALSE,fixed = TRUE)
stdcolumns <- grep("-std()",featurenames[[2]],value=FALSE)
#Join mean and std columns into a vector
columns <- c(meancolumns,stdcolumns)
columns <- sort.int(columns)

#Step3: Use descritpive activity names
activitynames <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activitynames) <- c("activity","activityname")
activities <- left_join(labels,activitynames,by = "activity")
activity <- activities$activityname
names(activity) <- "activity"

#Step 4: Clean data set with descriptive variable names
#Get values and feature names
values <- features[columns]
names(values) <- cleanfeaturenames(featurenames[[2]][columns])
#Add subject, activity and activity name columns
values <- cbind(values,activity,subjects)

#Step 5: Create data set with averages for each parameter grouped by subject and activity
averages <- getaverages(values)