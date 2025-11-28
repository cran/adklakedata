#' @title Load the lake shapefile for ADK
#' @description This function loads the primary geospatial boundary data for the Adirondack parks.
#'
#'
#'
#' @examples
#' \dontrun{
#' sites = adk_lakes()
#' }
#'
#' @export
adk_lakes = function(){
  return(adk_data('meta'))
}
