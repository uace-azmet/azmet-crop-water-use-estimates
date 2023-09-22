# fxnTableTitle: Build title for HTML table based on user input
# 
# @param: annualCrop - annual crop selected by user
# @return: tableTitle - title for HTML table based on user input


fxnTableTitle <- function(annualCrop) {
  tableTitle <- 
    htmltools::h4(
      htmltools::HTML(
        paste(
          "Water Use Estimates for", stringr::str_to_title(annualCrop), 
          sep = " "
        )
      ), 
      
      class = "table-title"
    )
  
  return(tableTitle)
}