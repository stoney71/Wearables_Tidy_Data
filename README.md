This repository contains the R code for the Getting and Cleaning Data Project on Coursera, and the Tidy Data that is created by the project.

The repository is available at:

https://github.com/stonie71/Wearables_Tidy_Data

Repository Contents:
--------------------

### run_analysis.R - A script to run the R code that produces the tidy data set.

### ave_per_activity_per_subject.txt - A txt file containing the final tidy data set.

### Codebook.R - A codebook containing the names and description of the variables in the tidy data set.

### README.md - This readme file.


Notes
-----

The script uses the dplyr package as well as the base package.

The source data consists of numerous files. All of these are read in by the script and saved as variables (which match the file name) in the R environment.

The contents of the features.txt file become the column names for the final tidy data set.

For the 5 steps that comprise the requirements for the project, these were addressed as follows:

1. "Merges the training and the test sets to create one data set." As noted above the various source files are read in and combined into two data frames: x_test and x_train. These are the test and train data sets respectively. These two data sets are combined together using the base package merge function, to create a merged data set: main_dataset. It was found in this case that the base merge function was more effective than the dplyr join functions.

2. "Extracts only the measurements on the mean and standard deviation for each measurement." Of all the 561 measurements contained in main_dataset only those with "std" or "mean" (representing standard deviation and mean respectively) are extracted, along with the first 2 columns which contain the Activity and Subject data. This extraction is saved into a new variable: reduced_dataset which is teh data set used for the rest of the script. The approach here is to retain the main_dataset in tact so that it could be used for further analysis if needed (although that is beyond the scope of this project).

3. "Uses descriptive activity names to name the activities in the data set" At this point the Activity names in the reduced_dataset consist of numbers 1 to 6 rather than activity names. So the next step was to read in the activity.txt file which contains the actual Activity Names, then create a new column in reduced_dataset (Activity) which is the proper Activity name. The dplyr::mutate function was used for this. As mutate adds Activity as the last column in the data frame, the next step was to rearrange the columns in reduced_dataset, by moving Activity to the 2nd column, using the dplyr::select function.

4. "Appropriately labels the data set with descriptive variable names." The descriptive variables are contained in the features.txt file. These labels were used when the files were first read in using the "col.names = features" option.

5. "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject." The next steps are to group and summarise the data. As it is grouping by TWO variables, Activity and Subject, a list is created (gdots) which is used as a parameter in the group_by_ function. Also a second list is created (wdots) to perform the mean (or average) function on each of the measurement columns, and this list is used in summarise_. The %>% pipe function, part of the dplyr package, is used for this. The ouput of this is saved as a new dataframe: ave_per_activity_per_subject. This dataframe is the Tidy Data, so is saved to a local file using the write.table function.




