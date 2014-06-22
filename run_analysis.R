## The goal is return one tidy data set by reading and merging all files from
## archive: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
## Tidy Data get X, Y and subject ID
## path is path from files
## complete_name is to complete names
##
## First, subsets extract only Mean and Standard Deviation on readData function.
## Data files from the \"UCI HAR Dataset\" on current folder


readData <- function(complete_name, path) {
  filepath <- file.path(path, paste0("y_", complete_name, ".txt"))
  y_data <- read.table(filepath, header=F, col.names=c("ActivityID"))
  
  filepath <- file.path(path, paste0("subject_", complete_name, ".txt"))
  subject_data <- read.table(filepath, header=F, col.names=c("SubjectID"))
  
  # getting collumns
  data_cols <- read.table("features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))
  
  # getting X file
  filepath <- file.path(path, paste0("X_", complete_name, ".txt"))
  data <- read.table(filepath, header=F, col.names=data_cols$MeasureName)
  
  # subsetting Mean and Standard Deviation
  subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", data_cols$MeasureName)
  
  # appling subset
  data <- data[,subset_data_cols]
  
  # getting Activity and Subject ID's
  data$ActivityID <- y_data$ActivityID
  data$SubjectID <- subject_data$SubjectID
  
  # return the data
  data
}

## getting test's data on test folder
readTestData <- function() {
  readData("test", "test")
}

## getting train's data on train folder
readTrainData <- function() {
  readData("train", "train")
}

## Merge train and test data sets and set column names
mergeData <- function() {
  data <- rbind(readTestData(), readTrainData())
  cnames <- colnames(data)
  cnames <- gsub("\\.+mean\\.+", cnames, replacement="Mean")
  cnames <- gsub("\\.+std\\.+", cnames, replacement="Std")
  colnames(data) <- cnames
  data
}

## Set activity name
applyActivityLabel <- function(data) {
  activity_labels <- read.table("activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
  activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)

  data_labeled <- merge(data, activity_labels)
  data_labeled
}

## Merge training and test, and set activity label
getMergedLabeledData <- function() {
  applyActivityLabel(mergeData())
}

## Create tidy data set 
getTidyData <- function(merged_labeled_data) {
  library(reshape2)
  
  # melting data
  id_vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(merged_labeled_data), id_vars)
  melted_data <- melt(merged_labeled_data, id=id_vars, measure.vars=measure_vars)
  
  # casting data
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean)
}

# Creating the tidy data set 
createTidyDataFile <- function(fname) {
  tidy_data <- getTidyData(getMergedLabeledData())
  write.table(tidy_data, fname)
}

createTidyDataFile("tidydataset.txt")