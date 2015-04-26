# Alan Nguyen
# Getting and Cleaning Data - Course Project

library(plyr)
library(data.table)

##### 1. Merge the training and test sets to create one data set.

# Load raw data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
set_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
set_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge 'x' data set via RBIND()
x_data <- rbind(x_train, x_test)

# Merge 'y' data set via RBIND()
y_data <- rbind(y_train, y_test)

# Merge to create ‘aggregate’ data set via rbind()
aggregate_data <- rbind(set_train, set_test)

##### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")

# Extract only columns with ‘mean’ or ‘std’ in field names
mean_and_std_data <- grep("-(mean|std)\\(\\)", features[, 2])

# Subset desired columns
x_data <- x_data[, mean_and_std_data]

# Update column names
names(x_data) <- features[mean_and_std_data, 2]

##### 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct column name
names(y_data) <- "activity"

##### 4. Appropriately label the data set with descriptive variable names.

# Update column name
names(aggregate_data) <- "subject"

# Bind all the data in a single data set
all_data <- cbind(x_data, y_data, aggregate_data)

##### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "tidy_averages_data_set.txt", row.name=FALSE);