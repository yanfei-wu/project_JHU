# Cache Function in R

## Introduction

In this programming assignment, an R function that is able to cache potentially time-consuming computations is wrote. This takes advantage of the scoping rules of the R language and how they can be manipulated to preserve state inside of an R object.  

The `<<-` operator can be used to assign a value to an object in an environment that is different from the current environment.  

## Catching the Mean  

Taking the mean of a numeric vector is typically a fast operation. However, for a very long vector, it may take too long to compute the mean, especially if it has to be computed repeatedly (e.g. in a loop). If the contents of a vector are not changing, it may make sense to cache the value of the mean so that when we need it again, it can be looked up in the cache rather than recomputed.  

The following functions are wrote:  

1.  `makeVector`: creates a special "vector", which is really a list containing a function to 
    a. set the value of the vector;  
    b. get the value of the vector;   
    c. set the value of the mean;   
    d. get the value of the mean 
2.  `cachemean`: this function first checks to see if the mean has already been calculated. If so, it `get` the mean from the cache and skips the computation. Otherwise, it calculates the mean of the data and sets the value of the mean in the cache via the `setmean` function. 

## Caching the Inverse of a Matrix 

Similarly, matrix inversion can also be a costly computation and there may be some benefit to caching the inverse of a matrix rather than computing it repeatedly (there are also alternatives to matrix inversion that we will not discuss here). Your assignment is to write a pair of functions that cache the inverse of a matrix. 

The following functions are wrote: 

1.  `makeCacheMatrix`: This function creates a special "matrix" object that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special "matrix" returned by `makeCacheMatrix` above. If the inverse has already been calculated (and the matrix has not changed), then `cacheSolve` should retrieve the inverse from the cache. 

The inverse of a square matrix can be computed with the `solve` function in R. For example, if `X` is a square invertible matrix, then `solve(X)` returns its inverse. 

*Assumption: the matrix supplied is always invertible.* 

