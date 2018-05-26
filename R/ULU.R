#' Computes a matrix from its eigenvalue decomposition
#' 
#' Computes a matrix from its eigenvalue decomposition
#' 
#' 
#' @param UL a list with first component ``U'', an n x r matrix and the second
#' component ``L'' an r x r diagonal matrix
#' @return an n x n matrix
#' @author Peter Hoff
#' @keywords multivariate models
"ULU" <-
function(UL){ 

## computes the reduced rank matrix

  UL$U%*%UL$L%*%t(UL$U)
                      }

