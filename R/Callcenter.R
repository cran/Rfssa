#' Number of Calls for a Bank.
#'
#' This dataset is a small call center for an anonymous bank (Brown et al.,
#' 2005). This dataset provides the exact time of the calls that were connected to
#' the center from January 1 to December 31 in the year 1999.
#' The data are aggregated into time intervals to obtain a data matrix. More
#' precisely, the \emph{(i,j)}'th element of the data matrix contains the call volume
#' during the \emph{j}th time interval on day \emph{i}. This dataset has been analyzed in several
#' prior studies; e.g. Brown et al. (2005),  Shen and Huang
#' (2005), Huang et al. (2008), and Maadooliat et al. (2015). Here, the data are aggregated  into time
#' intervals 6 minutes.
#' @name Callcenter
#' @format A dataframe with 87600 rows and 5 variables:
#' \describe{
#'   \item{calls}{The number of calls in 6 minutes aggregated interval.}
#'   \item{u}{a numeric vector to show the aggregated interval.}
#'   \item{Date}{Date time when the calls counts are recorded}.
#'   \item{Day}{Weekday associated with Date.}
#'   \item{Month}{Month associated with Date.}
#' }
#' @references
#' \enumerate{
#' \item
#' Brown, L., Gans, N., Mandelbaum, A., Sakov, A., Shen, H., Zeltyn, S., & Zhao, L. (2005).
#'  Statistical analysis of a telephone call center:
#'  A queueing-science perspective. \emph{Journal of the American statistical association}, \strong{100}(469), 36-50.
#'   \item
#'   Shen, H., & Huang, J. Z. (2005).
#'   Analysis of call center arrival data using singular
#'   value decomposition. Applied Stochastic Models in Business and Industry, 21(3), 251-263.
#'   \item
#'   Huang, J. Z., Shen, H., & Buja, A. (2008).
#'   Functional principal components analysis via
#'   penalized rank one approximation. \emph{Electronic Journal
#'   of Statistics}, \strong{2}, 678-695.
#'   \item
#'   Maadooliat, M., Huang, J. Z., & Hu, J. (2015).
#'   Integrating data transformation in principal
#'   components analysis. \emph{Journal of Computational and
#'   Graphical Statistics}, \strong{24}(1), 84-103.
#' }
#' @source \url{http://iew3.technion.ac.il/serveng/callcenterdata/index.html}
#' @seealso \code{\link{fssa}}
"Callcenter"


