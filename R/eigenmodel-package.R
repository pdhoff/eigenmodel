utils::globalVariables(c("R","Ranks","UL","X","Y","Z","b","mean_u","n","pm_b","pm_mu","pp_b","pp_l","pp_mu","pp_zq","tx","uRanks","var_u","xtx"))


#' Semiparametric Factor and Regression Models for Symmetric Relational Data 
#' 
#' Estimation of the parameters in a model for symmetric relational
#' data (e.g., the above-diagonal part of a square matrix), using a model-based
#' eigenvalue decomposition and regression. Missing data is accommodated, and a
#' posterior mean for missing data is calculated under the assumption that the
#' data are missing at random. The marginal distribution of the relational data
#' can be arbitrary, and is fit with an ordered probit specification.
#' 
#' \tabular{ll}{ Package: \tab eigenmodel\cr Type: \tab Package\cr Version:
#' \tab 1.10\cr Date: \tab 2018-05-26\cr License: \tab GPL Version 2 \cr }
#' 
#' @name eigenmodel-package
#' @aliases eigenmodel-package eigenmodel
#' @docType package
#' @author Peter Hoff <peter.hoff@@duke.edu>
#' @references Hoff (2007) ``Modeling homophily and stochastic equivalence in
#' symmetric relational data''
#' @keywords package
#' @examples
#' 
#' 
#' data(YX_Friend)
#' 
#' fit<-eigenmodel_mcmc(Y=YX_Friend$Y,X=YX_Friend$X,R=2,S=50,burn=50)
#' 
#' # in general you should run the Markov chain longer than 50 scans
#' 
#' plot(fit)
#' 
#' 
#' # people familiar with MCMC might want to implement 
#' # their own Markov chains: 
#' 
#' Y<-YX_Friend$Y
#' X<-YX_Friend$X
#' 
#' eigenmodel_setup(R=2)
#' 
#' for(s in 1:50) {   # you should run your chain longer than 50 scans
#' 
#'     Z<-rZ_fc() 
#'     UL<-rUL_fc()
#'     b<-rb_fc()  
#' 
#'                  }
#' 
#' 
#' #fit_Gen<-eigenmodel_mcmc(Y=Y_Gen,R=3,S=10000)
#' 
#' #fit_Pro<-eigenmodel_mcmc(Y=Y_Pro,R=3,S=10000)
#' 
#' 
#' 
#' 
NULL





#' Relations between words in the 1st chapter of Genesis
#' 
#' The i,j th entry of this matrix is the numerical count of the number of
#' times word i was next to word j in the first chapter of Genesis.
#' 
#' 
#' @name Y_Gen
#' @docType data
#' @keywords datasets
#' @examples
#' 
#' data(Y_Gen)
#' 
NULL





#' Butland's protein-protein interaction data
#' 
#' Butland's protein-protein interaction data
#' 
#' 
#' @name Y_Pro
#' @docType data
#' @references Butland et al (2005) ``Interaction network containing conserved
#' and essential protein complexes in Escherichia coli''
#' @keywords datasets
#' @examples
#' 
#' data(Y_Pro)
#' 
NULL





#' Sex, race and friendship data from a 12th grade classroom
#' 
#' A list in which \code{Y} encodes the presence of a friendship tie between 90
#' 12th graders. The array \code{X} indicates pairs of the same sex and of the
#' same race.
#' 
#' 
#' @name YX_Friend
#' @docType data
#' @source http://www.cpc.unc.edu/projects/addhealth/design
#' @keywords datasets
#' @examples
#' 
#' data(YX_Friend)
#' 
NULL



