% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ftsarithmetic.R
\name{-.fts}
\alias{-.fts}
\title{Subtraction of Functional Time Series}
\usage{
\method{-}{fts}(Y1, Y2)
}
\arguments{
\item{Y1}{an object of class \code{\link{fts}} or scalar}

\item{Y2}{an object of class \code{\link{fts}} or scalar}
}
\value{
an object of class \code{\link{fts}}.
}
\description{
A method that lets you perform functional time series (\code{\link{fts}}) subtraction and scalar subtraction.
}
\examples{

\dontrun{
require(fda)
require(Rfssa)
data(Callcenter) # Read data
u=seq(0,1,length.out=240) # Define domain of functional data
d=12 # number of basis elements
basis=create.bspline.basis(rangeval = c(0,1),nbasis = d) # create basis object
smooth.calls=smooth.basis(u, matrix(nrow=240,ncol=365,Callcenter$calls), basis)
Y=fts(smooth.calls$fd) # create functional time series
plot(Y)
Yminus=Y[4:8]-Y[14:18] # subtract elements of the functional time series from each other
plot(Yminus)
Yminus2=Y-2 # add 2 to every term in the functional time series
plot(Yminus2)
}

}
\seealso{
\code{\link{fts}}
}
