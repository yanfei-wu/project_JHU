# Analyzing Activity Data 

## Introduction

It is now possible to collect a large amount of data about personal movement using activity monitoring devices such as a [Fitbit](http://www.fitbit.com), [Nike Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or [Jawbone Up](https://jawbone.com/up). These type of devices are part of the "quantified self" movement -- a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. But these data remain under-utilized both because the raw data are hard to obtain and there is a lack of statistical methods and software for processing and interpreting the data.  

This project makes use of data from a personal activity monitoring device. This device collects data at 5 minute intervals through out the day. The data consists of two months of data from an anonymous
individual collected during the months of October and November, 2012 and include the number of steps taken in 5 minute intervals each day.  

## Data 

The data for this project is downloaded from the link below:  

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) [52K]

The variables included in this dataset are:  

* `steps`: Number of steps taking in a 5-minute interval (missing values are coded as `NA`)  
* `date`: The date on which the measurement was taken in YYYY-MM-DD format  
* `interval`: Identifier for the 5-minute interval in which measurement was taken  

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset.  


## Analysis  

- The data was loaded and processed into a format suitable for the analysis.  
- A histogram of the total number of steps taken each day was made and the mean total number of steps taken per day was calculated.   
- A time series plot of the 5-minute interval and the average number of steps taken, averaged across all days is made. The average daily activity pattern was analyzed.  
- The missing values in the dataset are imputed.  
- The activity patterns between weekdays and weekends are compared and a panel plot containing a time series plot of the 5-minute interval and the average number of steps taken, averaged across all weekday days or weekend days is made.  