#CodeBook

#Variables

"activity" 		Activity performed by subject
"subject" 		Subject performing the activity

Each of the following columns hold the average value for the measurement taken by the corresponding subject and activity

"tbodyaccmeanx" 	
"tbodyaccmeany" 
"tbodyaccmeanz" 
"tbodyaccstdx" 
"tbodyaccstdy" 
"tbodyaccstdz" 
"tgravityaccmeanx" 
"tgravityaccmeany" 
"tgravityaccmeanz" 
"tgravityaccstdx" 
"tgravityaccstdy"
"tgravityaccstdz" 
"tbodyaccjerkmeanx" 
"tbodyaccjerkmeany" 
"tbodyaccjerkmeanz" 
"tbodyaccjerkstdx" 
"tbodyaccjerkstdy" 
"tbodyaccjerkstdz" 
"tbodygyromeanx" 
"tbodygyromeany" 
"tbodygyromeanz" 
"tbodygyrostdx" 
"tbodygyrostdy" 
"tbodygyrostdz" 
"tbodygyrojerkmeanx" 
"tbodygyrojerkmeany" 
"tbodygyrojerkmeanz" 
"tbodygyrojerkstdx" 
"tbodygyrojerkstdy" 
"tbodygyrojerkstdz" 
"tbodyaccmagmean" 
"tbodyaccmagstd" 
"tgravityaccmagmean" 
"tgravityaccmagstd" 
"tbodyaccjerkmagmean" 
"tbodyaccjerkmagstd" 
"tbodygyromagmean" 
"tbodygyromagstd" 
"tbodygyrojerkmagmean" 
"tbodygyrojerkmagstd" 
"fbodyaccmeanx" 
"fbodyaccmeany" 
"fbodyaccmeanz" 
"fbodyaccstdx" 
"fbodyaccstdy" 
"fbodyaccstdz" 
"fbodyaccjerkmeanx" 
"fbodyaccjerkmeany" 
"fbodyaccjerkmeanz" 
"fbodyaccjerkstdx" 
"fbodyaccjerkstdy"
"fbodyaccjerkstdz" 
"fbodygyromeanx" 
"fbodygyromeany" 
"fbodygyromeanz" 
"fbodygyrostdx" 
"fbodygyrostdy" 
"fbodygyrostdz" 
"fbodyaccmagmean" 
"fbodyaccmagstd" 
"fbodybodyaccjerkmagmean" 
"fbodybodyaccjerkmagstd" 
"fbodybodygyromagmean" 
"fbodybodygyromagstd" 
"fbodybodygyrojerkmagmean" 
"fbodybodygyrojerkmagstd"

#Data

grouped_averages.txt: Output data file with table of grouped averages

#Transformations

1) Train and test data sets (subjects, features and labels) merged into 1 deta set
2) Filtered data set and extracted average and standard deviation feature readings
3) Replaced activity IDs with activity names for a more descriptive data set
4) Cleaned feature names
5) Merged measurements, activities and subjects into one table
6) Created new table with average values for each mean and std measurement grouped by activity and subject