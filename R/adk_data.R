filenames = c("chem" = "data/waterchem.csv",
              "crustacean" = "data/crustacean.csv",
              "meta" = "data/lake_characteristics.csv",
              "nutrient" = "data/nutrients.csv",
              "phyto" = "data/phyto.csv",
              "rotifer" = "data/rotifer.csv",
              "secchi" = "data/secchi.csv",
              "tempdo" = "data/temp_do_profiles.csv",
              "met" = "data/nldas_drivers_1979_2016.csv")

# Lakes covered by the package's curated view. The data archive on figshare
# also contains records for 25 additional ALTM-only lakes; the package
# restricts to the 28 originals so its scope matches the harmonized
# multi-program dataset described in Farrell et al. 2018.
.pkg_lakes <- function(path) {
  meta_path <- file.path(path, filenames[["meta"]])
  if (!file.exists(meta_path)) return(NULL)
  m <- utils::read.csv(meta_path, stringsAsFactors = FALSE)
  if ("data.availability" %in% names(m)) {
    m$lake.name[m$data.availability == "AEAP+ALTM"]
  } else {
    # Pre-0.7.0 archive: every lake in metadata is already an original lake
    m$lake.name
  }
}

#' @title Load ADK Data
#'
#' @description
#' Loads data from locally downloaded CSV files. Run \code{\link{check_dl_data}} before using this function.
#'
#' The package presents data for the 28 original lakes covered by both the
#' AEAP and ALTM monitoring programs, matching the scope of Farrell et al.
#' (2018, \emph{Scientific Data}, \doi{10.1038/sdata.2018.59}). The
#' underlying figshare archive (\doi{10.6084/m9.figshare.32305479}) additionally
#' contains chemistry and nutrient records for 25 ALTM-only lakes; those records
#' are filtered out by this function but are available directly from figshare
#' if needed.
#'
#' @param data_name A string choosing the data to load.
#' \tabular{ll}{
#' \strong{Data name (data_name)} \tab \strong{Data Description} \cr
#' chem \tab Lake Chemistry \cr
#' crustacean \tab Crustacean Zooplankton Biomass \cr
#' meta \tab Lake-specific metadata (type, location, morphology) \cr
#' nutrient \tab Lake Nutrients \cr
#' phyto \tab Phytoplankton Biomass Observations \cr
#' rotifer \tab Rotifer Zooplankton Biomass \cr
#' secchi \tab Lake Secchi Depth Observations \cr
#' tempdo \tab Temperature and Dissolved Oxygen Profiles \cr
#' met    \tab Lake-specific Meterology (air temp, wind, precip, etc) \cr
#' }
#'
#'
#' @import utils
#'
#' @examples
#' \dontrun{
#'
#' #grab secchi data and plot it
#' secchi = adk_data('secchi')
#' plot(as.POSIXct(secchi$date), secchi$secchi)
#' }
#' @export
adk_data = function(data_name){
  data_name = tolower(data_name)
  data_name = match.arg(data_name, names(filenames))
  path = local_path()
  check_dl_data()
  d <- read.csv(file.path(path, filenames[[data_name]]))

  # Restrict to the 28 original AEAP+ALTM lakes.
  lakes <- .pkg_lakes(path)
  if (!is.null(lakes) && "lake.name" %in% names(d)) {
    d <- d[d$lake.name %in% lakes, , drop = FALSE]
    rownames(d) <- NULL
  }
  tibble::as_tibble(d)
}
