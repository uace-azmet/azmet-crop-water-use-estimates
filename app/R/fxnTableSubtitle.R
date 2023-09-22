# fxnTableSubtitle: Build subtitle for HTML table based on current date
# 
# @param: azmetStation - AZMet station selected by user
# @return: tableSubtitle - subtitle for HTML table based on current date


fxnTableSubtitle <- function(azmetStation) {
  tableSubtitle <- 
    htmltools::p(
      htmltools::HTML(
        paste(
          "Based on evapotranspiration data from the AZMet", azmetStation, "station from", gsub(" 0", " ", format((Sys.Date() - 7), "%B %d, %Y")), "through", gsub(" 0", " ", format((Sys.Date() - 1), "%B %d, %Y")), 
          sep = " "
        )
      ), 
      
      class = "table-subtitle"
    )
  
  return(tableSubtitle)
}