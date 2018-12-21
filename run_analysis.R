rm(list=ls())

# Zip file variables
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
fileName <- "getdata_projectfiles.zip"
dataDir <- "UCI HAR Dataset"


# Download and upzip the dataset file
if (!file.exists(fileName)){
  download.file(fileURL, fileName, method="curl")
}
if (!file.exists(dataDir)) {
  unzip(fileName)
}

# Read the data into variables
features <- read.table(file.path(dataDir, "features.txt"))
activity_labels <- read.table(file.path(dataDir, "activity_labels.txt"))
subject_train <- read.table(file.path(dataDir, "train", "subject_train.txt"))
x_train <- read.table(file.path(dataDir, "train", "X_train.txt"))
y_train <- read.table(file.path(dataDir, "train", "y_train.txt"))
subject_test <- read.table(file.path(dataDir, "test", "subject_test.txt"))
x_test <- read.table(file.path(dataDir, "test", "X_test.txt"))
y_test <- read.table(file.path(dataDir, "test", "y_test.txt"))


# Set Column names
colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(activity_labels) <- c('activityId','activityType')

# When all are one and one is all
merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
merged_data <- rbind(merge_train, merge_test)

# Get the column names
column_names <- colnames(merged_data)
mean_and_std <- (grepl("activityId", column_names) | grepl("subjectId", column_names) |
                 grepl("mean..", column_names) | grepl("std..", column_names)
                )

mean_and_std_subset <- merged_data[ , mean_and_std == TRUE]

# Set activity names
activity_names <- merge(mean_and_std_subset, activity_labels, by='activityId', all.x=TRUE)

# Create a tidy data set with the averate of each variable for each activity and each subject
TidyData <- aggregate(. ~subjectId + activityId, activity_names, mean)
TidyData <- TidyData[order(TidyData$subjectId, TidyData$activityId),]

write.table(TidyData, "tidy_data.txt", row.name=FALSE)
