#' Sample from the multivariate normal distribution
#' 
#' Sample from the multivariate normal distribution
#' 
#' 
#' @param mu a p x 1 vector
#' @param Sig2 a p x p positive definite matrix
#' @return a p x 1 vector
#' @author Peter Hoff
#' @keywords distribution multivariate models
#' @examples
#' rmvnorm( c(0,0,0),diag(rep(3,1)) )   
"rmvnorm" <-
function(mu,Sig2){

## sample from multivariate normal distribution

  R<-t(chol(Sig2))
  t(R%*%(rnorm(length(mu),0,1)) +mu)
                           }

