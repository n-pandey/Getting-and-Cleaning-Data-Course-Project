# "run_analysis.R" performs below instructions step by step as per the assignment:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Variables used:

- lv_x_train, lv_y_train, lv_x_test, lv_y_test, lv_subject_train, lv_subject_test, lv_features, lv_activity_labels are extracted from downloaded data files.
- merge_train, merge_test, merged_data are merged data sets from above files.
- col_names, mean_std_col, filtered_mean_std_col & final_dataset are intermediate datasets used to derive a tidy dataset.
- TidyDataSet is the tidy dataset file as instructed in Step 5 of the assignment