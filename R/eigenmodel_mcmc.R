#' Approximate the posterior distribution of parameters in an eigenmodel
#' 
#' Construct approximate samples from the posterior distribution of the
#' parameters and latent variables in an eigenmodel for symmetric relational
#' data.
#' 
#' 
#' @param Y an n x n symmetric matrix with missing diagonal entries.
#' Off-diagonal missing values are allowed.
#' @param X an n x n x p array of regressors
#' @param R the rank of the approximating factor matrix
#' @param S number of samples from the Markov chain
#' @param seed a random seed
#' @param Nss number of samples to be saved
#' @param burn number of initial scans of the Markov chain to be dropped
#' @return a list with the following components: \item{Z_postmean}{posterior
#' mean of the latent variable in the probit specification}
#' \item{ULU_postmean}{posterior mean of the reduced-rank approximating matrix}
#' \item{Y_postmean}{the original data matrix with missing values replaced by
#' posterior means} \item{L_postsamp}{samples of the eigenvalues}
#' \item{b_postsamp}{samples of the regression coefficients} \item{Y}{original
#' data matrix} \item{X}{original regressor array} \item{S}{number of scans of
#' the Markov chain}
#' @author Peter Hoff
#' @keywords multivariate models
#' @examples
#' 
#' 
#' data(YX_Friend)
#' 
#' fit<-eigenmodel_mcmc(Y=YX_Friend$Y,X=YX_Friend$X,R=2,S=50,burn=50)
#' 
#' # in general you  should run the Markov chain longer than 50 scans
#' 
#' plot(fit)
#' 
#' #fit<-eigenmodel_mcmc(Y=Y_Gen,R=3,S=10000)
#' 
#' #fit<-eigenmodel_mcmc(Y=Y_Pro,R=3,S=10000)
#' 
#' 
"eigenmodel_mcmc" <-
function(Y,X=NULL,R=2,S=1000,seed=1,Nss=min(S,1000),burn=100) {


if(is.null(X)) { X<-array(dim=c(dim(Y)[1],dim(Y)[1],0)) }

mcmc_env<-new.env()

assign("Y",Y,mcmc_env)
assign("X",X,mcmc_env)
assign("R",R,mcmc_env)

environment(eigenmodel_setup)<-mcmc_env
environment(rZ_fc)<-mcmc_env
environment(rUL_fc)<-mcmc_env
environment(rb_fc)<-mcmc_env
environment(Y_impute)<-mcmc_env


## a simple MCMC routine

  Y_postsum<-Z_postsum<-ULU_postsum<-matrix(0,dim(Y)[1],dim(Y)[1])
  L_postsamp<-b_postsamp<-NULL   

  set.seed(seed)
  eigenmodel_setup(R,em_env=mcmc_env)

  nss<-0
  ss<-round(seq(burn+1,S+burn,length=Nss))
  si<-quantile(1:(S+burn),prob=seq(.05,1,length=20),type=1) 

  for(s in 1:(S+burn)) {

    Z<-rZ_fc() ; assign("Z",Z,mcmc_env)
    UL<-rUL_fc() ;  assign("UL",UL,mcmc_env)
    b<-rb_fc()   ;  assign("b",b,mcmc_env)

    if(is.element(s,si)){ 
    cat(round(100*s/(S+burn))," percent done (iteration ",s,") ",date(),"\n",sep="")
                         }

    if(is.element(s,ss)){ 
        nss<-nss+1
        L_postsamp<-rbind(L_postsamp,diag(UL$L))
        b_postsamp<-rbind(b_postsamp,b)
        Z_postsum<-Z_postsum+Z
        ULU_postsum<-ULU_postsum+ULU(UL) 
        Y_postsum<-Y_postsum+Y_impute()
                         }
                  }

eigenmodel_post<-list(Z_postmean=Z_postsum/nss,
                ULU_postmean=ULU_postsum/nss, 
                Y_postmean=Y_postsum/nss,
                L_postsamp=L_postsamp, b_postsamp=b_postsamp,Y=Y,X=X,S=S) 
                   
class(eigenmodel_post)<-"eigenmodel_post"
return(eigenmodel_post)
                                                                         }

