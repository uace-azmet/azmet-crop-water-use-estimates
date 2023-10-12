#' `fxnTableSubtitle.R` - Build subtitle for HTML table based on current date
#' 
#' @param azmetStation - AZMet station selected by user
#' @return `tableSubtitle` - Subtitle for HTML table based on current date


fxnTableSubtitle <- function(azmetStation) {
  tableSubtitle <- 
    htmltools::p(
      htmltools::HTML(
        paste(
          "Based on data from the AZMet", azmetStation, "station since", gsub(" 0", " ", format((Sys.Date() - 7), "%B %d, %Y")), "and through", gsub(" 0", " ", format((Sys.Date() - 1), "%B %d, %Y")), 
          sep = " "
        )
      ), 
      
      class = "table-subtitle"
    )
  
  return(tableSubtitle)
}