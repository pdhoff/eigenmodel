#' Computes a sociomatrix of regression effects
#' 
#' Computes a sociomatrix of regression effects
#' 
#' 
#' @param X an n x n x p array
#' @param b a p x 1 vector
#' @return an n x n matrix
#' @author Peter Hoff
#' @keywords multivariate models
"XB" <-
function(X,b) {

## generate sociomatrix of regression effects
  
  tmp<-matrix(0,nrow=dim(X)[1],ncol=dim(X)[2])
  for(k in seq(1,length(b),length=length(b))) { tmp<-tmp+b[k]*X[,,k] }
  tmp
                      }

