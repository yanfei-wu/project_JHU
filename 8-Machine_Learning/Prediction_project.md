# **Machine Learning of Exercise Data**
Yanfei Wu  
June 22, 2016  



## **Background**  
Using devices such as Fitbit is now possible to collect a large amount of data about personal activity relatively inexpensively. One thing that people regularly do with this type of devices is to quantify how much of a particular activity they do, but they rarely quantify how well they do it. In this project, the goal is to build a model with data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants to predict the manner they do the exercise. Specifically, we want to classify the activity data into 5 classes:    

Class A - exactly according to the specification  
Class B - throwing the elbows to the front   
Class C - lifting the dumbbell only halfway   
Class D - lowering the dumbbell only halfway   
Class E - throwing the hips to the front   

(More information is available at: http://groupware.les.inf.puc-rio.br/har.)  

## **Analysis**  
### *0. Packages and Libraries*  

```r
library(caret)
```

```
## Loading required package: lattice
```

```
## Loading required package: ggplot2
```

```r
library(rpart)
library(randomForest)
```

```
## randomForest 4.6-12
```

```
## Type rfNews() to see new features/changes/bug fixes.
```

```
## 
## Attaching package: 'randomForest'
```

```
## The following object is masked from 'package:ggplot2':
## 
##     margin
```

```r
set.seed(1232)
```

### *1. Get Data*   
First, the training data and the test data are downloaded and loaded into R.

```r
url_train <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
url_test <- "https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"

download.file(url_train, destfile = "traindata.csv")
download.file(url_test, destfile = "testdata.csv")

traindata <- read.csv("traindata.csv", na.strings = c("NA", "#DIV/0!", ""))
testdata <- read.csv("testdata.csv", na.strings = c("NA", "#DIV/0!", ""))
```

### *2. Slice Data*    
The *original training data* are then split into training (70%) and test sets (30%). We will later build model on the training set and test on the test set for cross-validation.  

```r
inTrain <- createDataPartition(y = traindata$classe, p = 0.7, list = F)
train <- traindata[inTrain,]
test <- traindata[-inTrain,]

d1 <- dim(train)
d2 <- dim(test)
```
Now the *new* training set has 13737 observations of 160 variables, and the *new* test set has 5885 observations of 160 variables. But we don't need to use all the variables as predictors. For example, some variables have large number of missing values (NAs). So we need to do some pre-processing of the data sets and select the predictors for our model.   

### *3. Basic Pre-processing*   
**Training Set**

```r
## remove the first 7 columns from training data
train_sub <- train[,-(1:7)]

## remove zero coviates
nzv <- nearZeroVar(train_sub, saveMetrics = T)[, 4]
index <- which(names(train_sub) %in% names(train_sub)[!nzv])
train_sub <- train_sub[, index]

## remove variables containing large percentage of NAs
nas <- NULL
for (i in 1: length(index)) nas[i] <- mean(is.na(train_sub[, i]))
index2 <- which(nas < 0.9)
train_sub <- train_sub[, index2]
```

**Test Data**  
We apply the same process to the test set.  

```r
## remove the first 7 columns from training data
test_sub <- test[,-(1:7)]

## remove zero coviates
test_sub <- test_sub[, index]

## remove variables containing large percentage of NAs
test_sub <- test_sub[, index2]
```

### *4. Pre-processing PCA*  
Up to this point, the dimension of the training subset is:  

```r
dim(train_sub)
```

```
## [1] 13737    53
```
There are still 53 variables, and many of them are correlated with each other. 

```r
M <- abs(cor(train_sub[, -53]))
diag(M) <- 0
n <- nrow(which(M >0.8, arr.ind = T))
```
For example, there are 30 variables with correlation coefficients > 0.8. Therefore, PCA is used to futher reduce the number of predictors.   

```r
preProc <- preProcess(train_sub[, -53], method = c("center", "scale", "pca"))
train_PC <- predict(preProc, train_sub)
test_PC <- predict(preProc, test_sub)
```

### *5. Models and Cross-validation*
**Trees**

```r
modFit_t <- rpart(classe ~ ., data = train_PC, method = "class")

## Predict with model
pred_t0 <- predict(modFit_t, train_PC, type = "class")
pred_t <- predict(modFit_t, test_PC, type = "class")

## Evaluate prediction on training set
confusionMatrix(pred_t0, train$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 2600  564  452  331  446
##          B  183  872  237  277  462
##          C  750  642 1396  519  341
##          D  290  370  269  776  209
##          E   83  210   42  349 1067
## 
## Overall Statistics
##                                           
##                Accuracy : 0.4885          
##                  95% CI : (0.4801, 0.4969)
##     No Information Rate : 0.2843          
##     P-Value [Acc > NIR] : < 2.2e-16       
##                                           
##                   Kappa : 0.3508          
##  Mcnemar's Test P-Value : < 2.2e-16       
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.6656  0.32807   0.5826  0.34458  0.42257
## Specificity            0.8176  0.89539   0.8014  0.90091  0.93899
## Pos Pred Value         0.5919  0.42935   0.3827  0.40543  0.60937
## Neg Pred Value         0.8602  0.84743   0.9009  0.87516  0.87836
## Prevalence             0.2843  0.19349   0.1744  0.16394  0.18381
## Detection Rate         0.1893  0.06348   0.1016  0.05649  0.07767
## Detection Prevalence   0.3198  0.14785   0.2656  0.13933  0.12747
## Balanced Accuracy      0.7416  0.61173   0.6920  0.62275  0.68078
```

```r
## Evaluate prediction on test set
confusionMatrix(pred_t, test$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1112  244  244  147  197
##          B   64  383  103  125  197
##          C  328  274  566  232  161
##          D  123  146   97  315   79
##          E   47   92   16  145  448
## 
## Overall Statistics
##                                          
##                Accuracy : 0.4799         
##                  95% CI : (0.467, 0.4927)
##     No Information Rate : 0.2845         
##     P-Value [Acc > NIR] : < 2.2e-16      
##                                          
##                   Kappa : 0.3387         
##  Mcnemar's Test P-Value : < 2.2e-16      
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.6643  0.33626  0.55166  0.32676  0.41405
## Specificity            0.8024  0.89697  0.79523  0.90957  0.93754
## Pos Pred Value         0.5720  0.43922  0.36259  0.41447  0.59893
## Neg Pred Value         0.8574  0.84919  0.89362  0.87337  0.87658
## Prevalence             0.2845  0.19354  0.17434  0.16381  0.18386
## Detection Rate         0.1890  0.06508  0.09618  0.05353  0.07613
## Detection Prevalence   0.3303  0.14817  0.26525  0.12914  0.12710
## Balanced Accuracy      0.7333  0.61661  0.67344  0.61817  0.67579
```

**Random Forest**  

```r
modFit_rf <- randomForest(classe ~., data = train_PC, prox = T, ntree = 50)  

## Predict with model
pred_rf0 <- predict(modFit_rf, train_PC)
pred_rf <- predict(modFit_rf, test_PC)

## Evaluate prediction on training set
confusionMatrix(pred_rf0, train$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 3906    0    0    0    0
##          B    0 2658    0    0    0
##          C    0    0 2396    0    0
##          D    0    0    0 2252    0
##          E    0    0    0    0 2525
## 
## Overall Statistics
##                                      
##                Accuracy : 1          
##                  95% CI : (0.9997, 1)
##     No Information Rate : 0.2843     
##     P-Value [Acc > NIR] : < 2.2e-16  
##                                      
##                   Kappa : 1          
##  Mcnemar's Test P-Value : NA         
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            1.0000   1.0000   1.0000   1.0000   1.0000
## Specificity            1.0000   1.0000   1.0000   1.0000   1.0000
## Pos Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
## Neg Pred Value         1.0000   1.0000   1.0000   1.0000   1.0000
## Prevalence             0.2843   0.1935   0.1744   0.1639   0.1838
## Detection Rate         0.2843   0.1935   0.1744   0.1639   0.1838
## Detection Prevalence   0.2843   0.1935   0.1744   0.1639   0.1838
## Balanced Accuracy      1.0000   1.0000   1.0000   1.0000   1.0000
```

```r
## Evaluate prediction on test set
confusionMatrix(pred_rf, test$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1662   23    5    4    0
##          B    6 1094   16    1    4
##          C    4   20  990   41    9
##          D    1    1   13  914   10
##          E    1    1    2    4 1059
## 
## Overall Statistics
##                                           
##                Accuracy : 0.9718          
##                  95% CI : (0.9672, 0.9759)
##     No Information Rate : 0.2845          
##     P-Value [Acc > NIR] : < 2.2e-16       
##                                           
##                   Kappa : 0.9643          
##  Mcnemar's Test P-Value : 6.465e-05       
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity            0.9928   0.9605   0.9649   0.9481   0.9787
## Specificity            0.9924   0.9943   0.9848   0.9949   0.9983
## Pos Pred Value         0.9811   0.9759   0.9305   0.9734   0.9925
## Neg Pred Value         0.9971   0.9906   0.9925   0.9899   0.9952
## Prevalence             0.2845   0.1935   0.1743   0.1638   0.1839
## Detection Rate         0.2824   0.1859   0.1682   0.1553   0.1799
## Detection Prevalence   0.2879   0.1905   0.1808   0.1596   0.1813
## Balanced Accuracy      0.9926   0.9774   0.9748   0.9715   0.9885
```
The model based on random forest shows much better accuracy and therefore we choose for any further predictions. Note that the **in-sample error** of random forest model is (0.9997, 1) within 95% confidence interval. The **out-of-sample error** of this model is (0.9672, 0.9759) within 95% confidence interval.   

### *6. Evaluate the 20 Test Data*  
The random forest model can be used to predict the *original test data* as below.


```r
predict(modFit_rf, predict(preProc, testdata))
```

## **Conclusion**  
The original training data is split into training/test sets followed by pre-processing the data. Models based on decision tree and random forest are built on the training set and evaluated on the test set. The random forest model is choosen to evaluate the original test data since it gives much smaller in-sample and out-of-sample errors.   

