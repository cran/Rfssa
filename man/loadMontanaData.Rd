% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_github_data.R
\name{loadMontanaData}
\alias{loadMontanaData}
\title{Load Montana Data from GitHub Repository}
\format{
A list containing two components:
\describe{
  \item{Temperature Data}{A 24 by 133 matrix of discrete samplings of intraday hourly temperature curves.}
  \item{NDVI Images}{An array with dimensions 33 by 33 by 133, where each 33 by 33 slice represents an NDVI image.}
}
}
\usage{
loadMontanaData()
}
\description{
This function retrieves the Montana dataset from a GitHub repository hosted at
https://github.com/haghbinh/dataset/Rfssa_dataset. Hosting datasets on GitHub
rather than including them in the Rfssa R package conserves storage space.
The Montana dataset contains intraday hourly temperature curves measured in degrees Celsius
and normalized difference vegetation index (NDVI) image data. Both types of data are recorded
near Saint Mary, Montana, USA. The NDVI images cover a region located between longitudes of
113.30 degrees West and 113.56 degrees West and latitudes of 48.71 degrees North and 48.78 degrees North.
For each recorded intraday temperature curve, an NDVI image was captured on the same day every
16 days, starting from January 1, 2008, and ending on September 30, 2013.
The dataset is valuable for environmental analysis, especially in the context of studying the impact
of temperature changes on vegetation. Combining both temperature and NDVI data can reveal more informative
patterns and insights.  The returned object is a raw dataset in `list` format;
This raw data can then be further processed and converted into a 'funts' object named 'Montana'.
 See \code{\link{funts}} for more details on  working with functional time series of class 'funts'.
}
\examples{
require(fda)
# Load Montana data
montana_data <- loadMontanaData()

# Extract variables
Temp <- montana_data$Temp
NDVI <- montana_data$NDVI

# Create a list for Montana data
Montana_Data <- list(Temp / sd(Temp), NDVI)

# Define basis functions
bs1 <- create.bspline.basis(c(0, 23), 11)
bs2 <- create.bspline.basis(c(1, 33), 13)
bs2d <- list(bs2, bs2)
bsmv <- list(bs1, bs2d)

# Convert to funts object
Y <- funts(X = Montana_Data, basisobj = bsmv,
           start = as.Date("2008-01-01"),
           end = as.Date("2013-09-30"),
           vnames = c("Normalized Temperature (\u00B0C)" , "NDVI"),
           dnames = list("Time", c("Latitude", "Longitude")),
           tname = "Date"
)

}
\references{
\enumerate{
  \item Diamond, H. J., Karl, T., Palecki, M. A., Baker, C. B., Bell, J. E., Leeper, R. D.,
     Easterling, D. R., Lawrimore, J. H., Meyers, T. P., Helfert, M. R., Goodge, G.,
     and Thorne, P.W. (2013). U.S. climate reference network after one decade of operations:
     status and assessment. [Read More](https://www.ncdc.noaa.gov/crn/qcdatasets.html).
     Last accessed April 2020.
  \item Tuck, S. L., Phillips, H. R., Hintzen, R. E., Scharlemann, J. P., Purvis, A., and
     Hudson, L. N. (2014). MODISTools – downloading and processing MODIS
     remotely sensed data in R. Ecology and Evolution, 4(24):4658–4668.
}
}
\seealso{
\code{\link{funts}}
}
