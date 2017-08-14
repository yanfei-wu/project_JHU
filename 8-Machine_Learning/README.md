# Machine Learning with Human Activity Data

## Background  
Using devices such as Jawbone Up, Nike FuelBand, and Fitbit it is now possible to collect a large amount of data about personal activity relatively inexpensively. These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it. 

In this project, the goal is to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. More information is available from the [website](http://groupware.les.inf.puc-rio.br/har).  

## Data  

The data for this project come from [here](http://groupware.les.inf.puc-rio.br/har). Specifically, the training data can be downloaded from [this link](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv). And the test data are available from [this link](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv).

## Models
The goal of this project is to build a classification model to predict the manner in which they did the exercise. The target variable is the `classe` variable in the training set. The five different classes are:  

- Class A - exactly according to the specification  
- Class B - throwing the elbows to the front   
- Class C - lifting the dumbbell only halfway   
- Class D - lowering the dumbbell only halfway   
- Class E - throwing the hips to the front

Random forest model is built. The **in-sample error** of the model is (0.9997, 1) within 95% confidence interval and the **out-of-sample error** is (0.9672, 0.9759) within 95% confidence interval.   