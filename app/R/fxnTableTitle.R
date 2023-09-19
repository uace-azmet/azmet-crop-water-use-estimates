# fxnTableTitle: Build title for HTML table based on user input
# 
# @param: stationName - AZMet station selected by user
# @param: annualCrop - annual crop selected by user
# @return: tableTitle - table title for HTML table based on user input


fxnTableTitle <- function(azmetStation, annualCrop) {
  tableTitle <- h4(htmltools::HTML(
    paste("Preview of", stringr::str_to_title(annualCrop), "Data from the AZMet", azmetStation, "station", sep = " ")
  ))
  
  return(tableTitle)
}