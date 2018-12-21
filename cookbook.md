The file "run_analysis.R" does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See README.md for usage and instructions

## The variables:
* `activity_labels` - list of activities performed by the person
* `features` x_data column names
* `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the file download.
* `x_data`, `y_data` and `subject_data` merge the previous datasets to further analysis.
* `x_data` dataset, which are applied to the column names stored in
