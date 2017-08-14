# Getting and Cleaning Data

## Introduction

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

## Data 

The data analyzed in this project was collected from the accelerometers from the Samsung Galaxy S smartphone. As is known, one of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. These wearable devices generate a ton of data useful for training more powerable algorithms. 

A full description of the dataset used here is available at [this site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) where the data was obtained.  

## Data Cleaning  

An R script called run_analysis.R is wrote that does the following: 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- Create a second, independent tidy data set with the average of each variable for each activity and each subject.

In addition to the R script, this repo also contains the tidy data set and a code book that describes the variables, the data, and any transformations or work performed to clean up the data called `CodeBook.md`. 