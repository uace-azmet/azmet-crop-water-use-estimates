#' `fxnTableCaption.R` - Build caption for HTML table based on user input
#' 
#' @param azmetStation - AZMet station selected by user
#' @param annualCrop - Annual crop selected by user
#' @return `tableCaption` - Caption for HTML table based on user input


fxnTableCaption <- function(azmetStation, annualCrop) {
  tableCaption <- 
    htmltools::p(
      htmltools::HTML(
        paste(
          "The total water use estimate from the AZMet",
          azmetStation,
          "station for",
          annualCrop,
          "since the selected planting date and through",
          gsub(" 0", " ", format((Sys.Date() - 1), "%B %d, %Y")),
          "is",
          "NUMBER OUTPUT FUNCTION `seasonCumulativeWaterUseValueYumaValley()`", 
          "inches.", 
          
          sep = " "
        )
      ), 
      
      class = "table-caption"
    )
  
  return(tableCaption)
}