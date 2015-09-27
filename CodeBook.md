## Code Book for Course Project script

Description of cleaning and processing data, in order to provide tidy data set
The final data set contains the averages of feature measures, grouped by subjects and activities

## Input Data

### Description files
* activity_labels.txt - contains description names of activities
* features.txt - contains all measured features names

### Test files
* X_test.txt - all features measurements
* y_test.txt - activities for each measurement
* subject_test.txt - subjects for each measurement

### Train files
* X_train.txt - all features measurements
* y_train.txt - activities for each measurement
* subject_train.txt - subjects for each measurement


## Processing stages

### Reading files
Measurement data were loaded to "x_test" data frame
Data columns names are set to features names
Subjects and activities columns were added

### Merging data sets
Test and trains data sets were merged using rbind function, generating the complete data frame "x_onedataset"
The complete data set contains 3 "key" columns (stage,subject,activity) and 79 "data" columns (features measurements)

### Subsetting to pick only mean and std
Using function grepl, the data frame "x_subset" was generated, containg only mean and std measurements

### Group by and summarise
Using loop commands, each 

