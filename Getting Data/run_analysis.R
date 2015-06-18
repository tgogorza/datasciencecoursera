source("cleanfeaturenames.R")

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


#Merge Data
subjects <- rbind(subjtrain,subjtest)
features <- rbind(featurestrain,featurestest)
labels <- rbind(labelstrain,labelstest)

#Set column names
names(features) <- featurenames[[2]]
names(subjects) <- c("subject")
names(labels) <- c("activity")
#Clean column names
#INSERT REGEX EXPRESSIONS TO CORRECTLY FORMAT FEATURE NAMES

#Extract mean and std from each measurement
meancolumns <- grep("-mean()",featurenames[[2]],value=FALSE,fixed = TRUE) #filtrar los meanFreq()
stdcolumns <- grep("-std()",featurenames[[2]],value=FALSE)
#Join mean and std columns into a vector
columns <- c(meancolumns,stdcolumns)
columns <- sort.int(columns)
#Get values and feature names
values <- features[columns]
names(values) <- cleanfeaturenames(featurenames[[2]][columns])
#Add subject and activity columns
values <- cbind(values,labels,subjects)
#Save data to a csv file
write.csv(values,"clean_data.csv")