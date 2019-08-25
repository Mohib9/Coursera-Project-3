library(dplyr)
library(data.table)

##Read features.txt and activity.txt
features <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/features.txt")
activity <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/activity_labels.txt")

##Read test data
x_test <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/X_test.txt")
y_test <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/y_test.txt")
subject_test <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/subject_test.txt")

##Read train data
x_train <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/X_train.txt")
y_train <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/y_train.txt")
subject_train <- read.table("C:/Users/muham/OneDrive/Documents/Coursera-Project-3/subject_train.txt")

##Renaming columns train / test
names(subject_train) <- "ID"
names(y_train) <- "label"

names(subject_test) <- "ID"
names(y_test) <- "label"

names(features) <- c("num", "formulas")

names(x_train) <- c(as.character(features$formulas))
names(x_test) <- c(as.character(features$formulas))

##Join test data
joined_test <- cbind(subject_test, y_test, x_test)

##join train data
joined_train <- cbind(subject_train, y_train, x_train)

##combining test & train
comb_data <- rbind(joined_train, joined_test)

##targeting columns with std and mean
stdmeancols <- grep("mean|std", names(comb_data), ignore.case = TRUE)
req_columns <- c(1,2,stdmeancols)

##extracting req columns from data table
comb_data <- as.data.table(comb_data)
extracted_data <- comb_data[, req_columns, with=FALSE]

##Using descriptive activity names instead of labels
extracted_data$label <- activity[extracted_data$label, 2]

##Removing regular expressions from column names. Note here that I could have modified the columns names like "accelerometer" etc...but that would
##would have made it all verbose. I think its better to have concise info in the column names without the expressions.
names(extracted_data) <- gsub("-","", names(extracted_data))
names(extracted_data) <- gsub("\\()","", names(extracted_data))

##Grouping data for last part 
extracted_data <- group_by(extracted_data, ID, label)

##Storing mean to a variable called finalized
finalized <- summarize_all(extracted_data, funs(mean))

##Storing finalized to a text doc
write.table(finalized, "finalized.txt", row.names = FALSE)