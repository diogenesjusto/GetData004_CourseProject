GetData004_CourseProject
========================

Course Project for coursera's course: Getting and Cleaning Data - 2014, June.

Executing script

    Clone this repo
    Download the data set and extract (see above). 
    Change current directory to new folder.
    Execute <path to>/run_analysis.R
    Tidy dataset will be created by tidydataset.txt
    Code book is available here

Premisses

    Data set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ) 
    unzipped in folders named train and test.

    To this data:
        Measurements are in X_<dataset>.txt file
        Subject is in subject_<dataset>.txt file
        Activity are in y_<dataset>.txt file
    
    Activity codes and labels are in activity_labels.txt.
    Measurements taken are in file features.txt as they appear in X_<dataset>.txt files.
    Columns with means contain ...mean() in them.
    Columns with standard deviations contain ...std() in them.

