
#It is important to downloas the csv file given in Coursera
library(plyr)
# 1- Merge the training and test sets to create one data set
###############################################################################
#I will firt import all the requiered Datasets
X_test <- read.table("~/Downloads/UCI HAR Dataset/test/X_test.txt", quote="\"")
y_train <- read.table("~/Downloads/UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("~/Downloads/UCI HAR Dataset/test/subject_test.txt", quote="\"")
X_train <- read.table("~/Downloads/UCI HAR Dataset/train/X_train.txt", quote="\"")
y_test <- read.table("~/Downloads/UCI HAR Dataset/test/y_test.txt", quote="\"")
subject_train <- read.table("~/Downloads/UCI HAR Dataset/train/subject_train.txt", quote="\"")
# Merge the training and test dataset for "x"
x_data <- rbind(X_train, X_test)
head(x_data)
# Merge the training and test dataset for "y"
y_data <- rbind(y_train, y_test)
head(y_data)
# Merge the training and test datasets for "subjects"
subject_data <- rbind(subject_train, subject_test)
head(subject_data)

# Step 2
# Extract only the measurements on the mean and standard deviation for each measurement
###############################################################################
#Import the features dataset
features <- read.table("~/Downloads/UCI HAR Dataset/features.txt", quote="\"")
head(features)
# select the colums where mean() or std() is found in the features´ dataset Second column.
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
head(mean_and_std_features)
# correct the column names on x_data with the names on mean_and_std_features
names(x_data) <- features[mean_and_std_features, 2]
head(x_data)
# Step 3
# Use descriptive activity names to name the activities in the data set
###############################################################################
activities <- read.table("~/Downloads/UCI HAR Dataset/activity_labels.txt", quote="\"")
head(activities)
# In y_data dataset please write the first column of the activities dataset  depending on the activities 2 column
y_data[, 1] <- activities[y_data[, 1], 2]
head(y_data)
# Lets name our variable activity
names(y_data) <- "activity"

# Step 4
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct column name
names(subject_data) <- "subject"
head(subject_data)
# bind all the data in a single data set.Make sure subject is the first one not the last.
all_data <- cbind(subject_data,x_data, y_data)
head(all_data)
# Step 5
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject

###############################################################################

#I will create a tiny dataset were i will agregate the subject and activity variable of the all_data dataset.
#It will only shoy the mean for those variables.

data2<-aggregate(. ~subject + activity, all_data, mean)
head(data2)
write.table(data2, file = "tidydata.txt",row.name=FALSE)

