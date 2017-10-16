
## Create data folder if it does not exists and download the dataset

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip dataSet to same directory

unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Reading x & y training tables:

lv_x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
lv_y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
lv_subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## Reading x & y testing tables:

lv_x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
lv_y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
lv_subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## Reading features:

lv_features <- read.table('./data/UCI HAR Dataset/features.txt')

## Reading activity labels:

lv_activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assigning proper names

colnames(lv_x_train) <- lv_features[,2] 
colnames(lv_y_train) <-"activityId"
colnames(lv_subject_train) <- "subjectId"

colnames(lv_x_test) <- lv_features[,2] 
colnames(lv_y_test) <- "activityId"
colnames(lv_subject_test) <- "subjectId"

colnames(lv_activity_labels) <- c('activityId','activityType')

## Merging dataset

merge_train <- cbind(lv_y_train, lv_subject_train, lv_x_train)
merge_test <- cbind(lv_y_test, lv_subject_test, lv_x_test)
merged_data <- rbind(merge_train, merge_test)

## Read column names and create placeholder for ID, mean and SD

col_names <- colnames(merged_data)

mean_std_col <- (grepl("activityId" , col_names) | grepl("subjectId" , col_names) | 
                   grepl("mean.." , col_names) |  
                   grepl("std.." , col_names))

## Filtering dataset to be used for needed columns

filtered_mean_std_col <- merged_data[ , mean_std_col == TRUE]

## final dataset

final_dataset <- merge(filtered_mean_std_col, lv_activity_labels, by='activityId', all.x=TRUE)

## Ordered tidy second dataset

sec_tidy_data_set <- aggregate(. ~subjectId + activityId, final_dataset, mean)
sec_tidy_data_set <- sec_tidy_data_set[order(sec_tidy_data_set$subjectId, sec_tidy_data_set$activityId),]

## Writing tidy dataset to a file

write.table(sec_tidy_data_set, "./data/TidyDataSet.txt", row.name=FALSE)
