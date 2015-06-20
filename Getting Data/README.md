#README


Run Analysis (run_analysis.R): 

	This is the main script, and performs the following actions:
	- Load training and test sets
	- Merge both sets into 1 data set
	- Extract mean and standard deviation parameters values from each measurement
	- Replaces activity ID values with descriptive activity names
	Being this the main script, it also calls the cleanfeaturenames and get_averages sripts
	
Clean feature names (cleanfeaturenames.R) 

	Input: List of column names
	Output: Cleanes list of column names
	Given a list of column names, this script will clean the names by removing punctuation and odd characters, and also moving every letter to lower case.

Get averages (get_averages.R)
	
	Input: Data table
	Groups data by subject and activity and gets the average for each parameter. Also saves the new table into the "grouped_averages.txt" file
	