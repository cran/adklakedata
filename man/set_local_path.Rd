% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_dl_data.R
\name{set_local_path}
\alias{set_local_path}
\title{Set custom local file path}
\usage{
set_local_path(path)
}
\arguments{
\item{path}{Full path to custom folder, will be created if it doesn't exist.}
}
\description{
Data files are locally cached (they are too large to be distributed
with the CRAN package). These cached files are stored in your user
data directory, or a custom directory set using \code{set_local_path}.
}
\examples{
# set custom path to local temp directory
set_local_path(tempdir())


}
