# raw test data
X_test <- read.table("UCI HAR Dataset//test//X_test.txt", colClasses="numeric", row.names=NULL)
Y_test <- read.table("UCI HAR Dataset//test//Y_test.txt", colClasses="integer", row.names=NULL)
subject_test <- read.table("UCI HAR Dataset//test//subject_test.txt", colClasses="integer", row.names=NULL)[[1]]

# raw train data
X_train <- read.table("UCI HAR Dataset//train//X_train.txt", colClasses="numeric", row.names=NULL)
Y_train <- read.table("UCI HAR Dataset//train//Y_train.txt", colClasses="integer", row.names=NULL)
subject_train <- read.table("UCI HAR Dataset//train//subject_train.txt", colClasses="integer", row.names=NULL)[[1]]

# feature names and activity names
features <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors=F, row.names=NULL)[[2]]
activities <- read.table("UCI HAR Dataset//activity_labels.txt", stringsAsFactors=F, row.names=NULL)[[2]]

# make master data frame
test <- X_test
names(test) <- features
test$Activity <- activities[c(Y_test[[1]])]
test$Subject <- subject_test

train <- X_train
names(train) <- features
train$Activity <- activities[c(Y_train[[1]])]
train$Subject <- subject_train

master <- rbind(test, train)

# extract the columns that correspond to mean or std of the measurements, together with
# the activity name and subject number for that observation
vars <- sort(c(grep("mean\\(\\)", names(master)), 
               grep("std\\(\\)", names(master)), 
               (1:ncol(master))[names(master) %in% c("Activity", "Subject")]))

final <- master[,vars]

clean <- function(x) {
  x <- sub("BodyBody", "Body", x, fixed=T)
  x <- sub("-mean()", "Mean", x, fixed=T)
  x <- sub("-std()", "Std", x, fixed=T)
  sub("-", ".", x, fixed=T)
}

names(final) <- sapply(names(final), clean)

# make a new dataframe that has the means for each subject/activity pair
# uses data.table to make it easier (and faster!) to calculate the correct means
# the data.table is then cast back to a data.frame (so, e.g., a client can subset it
# in the standard ways). Copying everything around like this is probably not a good idea,
# especially for larger data sets?
library(data.table)
fin <- as.data.table(final)
mean.frame <- as.data.frame(fin[, as.data.frame(t(colMeans(.SD))), by=list(Activity, Subject)])
write.csv(mean.frame, file="tidy.txt")