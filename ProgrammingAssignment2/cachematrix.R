## Set of Functions to Build a matrix that can cache it's inverse and a function
## that computes the inverse and caches it before returning it or returns a cached version if the function
## has already been called on the object

## makeCacheMatrix create a martix like object with the
## special feature that it can store it's inverse


makeCacheMatrix <- function(x = matrix()) {
    x_inv <- NULL
    set <- function(y){
        x <<- y
        x_inv <<- NULL
    }
    get <- function() {x}
    set_inv <- function(inv){x_inv <<- inv}
    get_inv <- function() {x_inv}
    list(set = set,
         get = get,
         set_inv = set_inv,
         get_inv = get_inv)
    
}


## cacheSolve return the Inverse of the matrix in makeCacheMatrix.
## if the inverse has already been created it returns a cached version
## otherwise it will compute the inverse and cache the results 

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$get_inv()
    if(!is.null(m)){
        message("getting cached data")
        return(m)
    }
    mat <- x$get()
    inv <- solve(mat)
    x$set_inv(inv)
    return(inv)    
}
