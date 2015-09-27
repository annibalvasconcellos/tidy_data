## Code Book for Course Project script

Description of cleaning and processing data, in order to provide tidy data set<br />
The final data set contains the averages of feature measures, grouped by subjects and activities

## Input Data

### Description files
* activity_labels.txt - contains activities description names 
* features.txt - contains all measured features names

### Test files
* X_test.txt - all features measurements
* y_test.txt - activities related to each measurement
* subject_test.txt - subjects for each measurement

### Train files
* X_train.txt - all features measurements
* y_train.txt - activities related to each measurement
* subject_train.txt - subjects for each measurement

Description files shoul be be located in the working directory, and "test" and "train" files in the corresponding subdirectories


## Processing stages

### Reading files
Measurement data were loaded to "x_test" data frame<br />
Data columns names are set to corresponding features names<br />
Subjects and activities columns were added

### Merging data sets
Test and trains data sets were merged using rbind function, generating the complete data frame "x_onedataset"<br />
The complete data set contains 3 "key" columns (stage,subject,activity) and 79 "data" columns (features measurements)

### Subsetting to pick only mean and std
Using function grepl, the data frame "x_subset" was generated, containg only mean and std measurements

### Group by and summarise
Using loop commands, each feature measurement column is summarised<br />
Each summarising result is added to the final data set "mean_total_table", which contains the average values grouped by subject, activity and feature name

The complete process took about 5 minutes to run, in a 64-bit notebook


## Save result table
Final data set were saved using function write.table, generating file "tidy_data.txt"<br />
This step is not included in the R script


