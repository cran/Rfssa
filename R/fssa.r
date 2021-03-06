#' Functional Singular Spectrum Analysis
#'
#' This is a function which performs the decomposition (including embedding
#'  and  functional SVD steps) stage for univariate functional singular spectrum analysis (ufssa)
#'  or multivariate functional singular spectrum analysis (mfssa)
#'  depending on whether the supplied input is a univariate or
#'  multivariate functional time series (\code{\link{fts}}) object.
#' @return An object of class \code{fssa}, which is a list of
#' multivariate functional objects and the following components:
#' \item{values}{a numeric vector of eigenvalues}
#' \item{L}{window length}
#' \item{N}{length of the functional time series}
#' \item{Y}{the original functional time series}
#' @param Y an object of class \code{\link{fts}}
#' @param L window length
#' @param type type of FSSA with options of \code{type = "ufssa"} or \code{type = "mfssa"}
#' @importFrom fda fd inprod eval.fd smooth.basis is.fd create.bspline.basis
#' @examples
#'
#' \dontrun{
#' ## Univariate FSSA Example on Callcenter data
#' data("Callcenter")
#' require(fda)
#' require(Rfssa)
#' ## Define functional objects
#' D <- matrix(sqrt(Callcenter$calls),nrow = 240)
#' N <- ncol(D)
#' time <- seq(ISOdate(1999,1,1), ISOdate(1999,12,31), by="day")
#' K <- nrow(D)
#' u <- seq(0,K,length.out =K)
#' d <- 22 #Optimal Number of basis elements
#' basis <- create.bspline.basis(c(min(u),max(u)),d)
#' Ysmooth <- smooth.basis(u,D,basis)
#' ## Define functional time series
#' Y <- fts(Ysmooth$fd,time = time)
#' plot(Y,ylab = "Sqrt of Callcenter", xlab = "Intraday intervals")
#'
#' ## Univariate functional singular spectrum analysis
#' L <- 28
#' U <- fssa(Y,L)
#' plot(U,d=13)
#' plot(U,d=9,type="lheats")
#' plot(U,d=9,type="lcurves")
#' plot(U,d=9,type="vectors")
#' plot(U,d=10,type="periodogram")
#' plot(U,d=10,type="paired")
#' plot(U,d=10,type="wcor")
#' gr <- list(1,2:3,4:5,6:7,8:20)
#' Q <- freconstruct(U, gr)
#' plot(Y,main="Call Numbers(Observed)")
#' plot(Q[[1]],main="1st Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[2]],main="2nd Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[3]],main="3rd Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[4]],main="4th Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[5]],main="5th Component(Noise)",ylab = " ", xlab = "Intraday intervals")
#'
#' ## Other visiualisation types for object of class "fts":
#'
#' plot(Q[[1]], type="3Dsurface", main="1st Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[2]][1:60], type="heatmap", main="2nd Component",ylab = " ", xlab = "Intraday intervals")
#' plot(Q[[3]][1:60], type = "3Dline", main="3rd Component",ylab = " ", xlab = "Intraday intervals")
#'
#' ## Multivariate FSSA Example on Bivariate Satelite Image Data
#' require(fda)
#' require(Rfssa)
#' ## Raw image data
#' NDVI=Jambi$NDVI
#' EVI=Jambi$EVI
#' time <- Jambi$Date
#' ## Kernel density estimation of pixel intensity
#' D0_NDVI <- matrix(NA,nrow = 512, ncol = 448)
#' D0_EVI <- matrix(NA,nrow =512, ncol = 448)
#' for(i in 1:448){
#'   D0_NDVI[,i] <- density(NDVI[,,i],from=0,to=1)$y
#'   D0_EVI[,i] <- density(EVI[,,i],from=0,to=1)$y
#' }
#' ## Define functional objects
#' d <- 11
#' basis <- create.bspline.basis(c(0,1),d)
#' u <- seq(0,1,length.out = 512)
#' y_NDVI <- smooth.basis(u,as.matrix(D0_NDVI),basis)$fd
#' y_EVI <- smooth.basis(u,as.matrix(D0_EVI),basis)$fd
#' y=list(y_NDVI,y_EVI)
#' ## Define functional time series
#' Y <- fts(y,time=time)
#' plot(Y[1:100],ylab = c("NDVI","EVI"),main = "Probability Kernel Density")
#' plot(Y, type = '3Dsurface', var=1,ylab = c("NDVI"),main = "Probability Kernel Density")
#' plot(Y, type = '3Dline', var=2,ylab = c("EVI"),main = "Probability Kernel Density")
#' plot(Y, type = 'heatmap',ylab = c("NDVI","EVI"),main = "Probability Kernel Density")
#' L=45
#' ## Multivariate functional singular spectrum analysis
#' U=fssa(Y,L)
#' plot(U,d=10,type='values')
#' plot(U,d=10,type='paired')
#' plot(U,d=10,type='lheats', var = 1)
#' plot(U,d=10,type='lcurves',var = 1)
#' plot(U,d=10,type='lheats', var = 2)
#' plot(U,d=10,type='lcurves',var = 2)
#' plot(U,d=10,type='wcor')
#' plot(U,d=10,type='periodogram')
#' plot(U,d=10,type='vectors')
#' recon <- freconstruct(U = U, group = list(c(1),c(2,3),c(4)))
#' plot(recon[[1]],type = '3Dsurface',var=1, ylab = "NDVI")
#' plot(recon[[2]],type = '3Dsurface',var=1, ylab = "NDVI")
#' plot(recon[[3]],type = '3Dsurface',var=1, ylab = "NDVI")
#' plot(recon[[1]],type = '3Dsurface',var=2, ylab = "EVI")
#' plot(recon[[2]],type = '3Dsurface',var=2, ylab = "EVI")
#' plot(recon[[3]],type = '3Dsurface',var=2, ylab = "EVI")
#'
#'}
#' @useDynLib Rfssa
#' @export
fssa <- function(Y, L = NA, type="fssa") {
  if(is.fd(Y) & length(dim(Y$coefs)) == 2L )   Y <- fts(Y) else
    if(class(Y) != "fts") stop("The class of Y is not acceptable")
  if(is.na(L))  L <- floor(Y$N / 2L)
  if(Y$p==1 && type=="fssa"){
    out <- ufssa(Y,L)
  } else if (Y$p > 1 || type=="mfssa") {
    out <- mfssa(Y,L)
  } else stop("Error in Type or Dimension")
  class(out) <- "fssa"
  return(out)
}


