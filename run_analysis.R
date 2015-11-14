## Before running this script, ensure working dir contains features.txt and
## /test and /train subdirs.

library(dplyr)

## Read in the Wearables data files into separate datafames. In features.txt
## extract just the 2nd column. This vector becomes the column names when 
## x_test and x_train are read in.

features <- read.table("./features.txt", stringsAsFactors = FALSE)
features <- as.character(features[[2]])

subject_test <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt", col.names = features)
y_test <- read.table("./test/Y_test.txt")

subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt", col.names = features)
y_train <- read.table("./train/Y_train.txt")

## Using x_test as the main dataframe, add the activity number (y_test) and
## subject (subject_test) to x_test, using the cbind function.

x_test <- cbind(Activity.Num = y_test$V1, Subject = subject_test$V1, x_test)

## Repeat this same process for train data.

x_train <- cbind(Activity.Num = y_train$V1, Subject = subject_train$V1, x_train)

## Now Merge x_test and x_train

main_dataset <- merge(x_test, x_train, all = TRUE)

## Extract all measurements regarding the mean or standard deviation 
## for each measurement and save as a new reduced_dataset

reduced_dataset <- select(main_dataset, 1, 2, matches("mean|std"))

## read in activity_labels.txt file to obtain activity index then rename
## variables in Activity column to more meaningful data.

activity_labels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

reduced_dataset <- mutate(reduced_dataset, Activity = 
                activity_labels[reduced_dataset$Activity.Num, 2])

## Remove Activity.Num col as its no longer needed. Move Activity column to 
## the 1st column position.

reduced_dataset <- select(reduced_dataset, Activity, Subject, matches("mean|std"))

## group by Activity & Subject, and summarise based on mean, to produce tidy
## data. 
## First create dots to use in group and summarise:

gdots <- lapply(c("Activity", "Subject"), as.symbol)
cols <- names(reduced_dataset)[-(1:2)]
wdots <- sapply(cols ,function(x) substitute(mean(x), list(x=as.name(x))))

## Next, create the new tidy data by piping the reduced_dataset through group
## and summarise functions with above dots.

ave_per_activity_per_subject <- reduced_dataset %>% group_by_(.dots=gdots) %>%
        summarise_(.dots = wdots)

## Save the tidy data to a file

filename <- "./ave_per_activity_per_subject.txt"
write.table(ave_per_activity_per_subject, file = filename, row.names = FALSE)