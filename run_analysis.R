## Read in Wearables data files into separate datafames:

activity_labels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

## Read in features.txt and extract just the 2nd column. This vector becomes the  
## column names when x_test and x_train are read in.

features <- read.table("./features.txt", stringsAsFactors = FALSE)
features <- as.character(features[[2]])

subject_test <- read.table("./test/subject_test.txt")
x_test <- read.table("./test/X_test.txt", col.names = features)
y_test <- read.table("./test/Y_test.txt")

subject_train <- read.table("./train/subject_train.txt")
x_train <- read.table("./train/X_train.txt", col.names = features)
y_train <- read.table("./train/Y_train.txt")

## Using x_test as the main dataframe, add the activity (y_test) and subject
## (subject_test) to x_test, using the cbind function.

x_test <- cbind(Activity = y_test$V1, Subject = subject_test$V1, x_test)

## Repeat this same process for train data.

x_train <- cbind(Activity = y_train$V1, Subject = subject_train$V1, x_train)

## Now Merge x_test and x_train

main_dataset <- merge(x_test, x_train, all = TRUE)