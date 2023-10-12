#' `fxnTableCaption.R` - Build caption for HTML table based on user input
#' 
#' @return `tableCaption` - Caption for HTML table based on user input


fxnTableCaption <- function(azmetStation, annualCrop) {
  tableCaption <- 
    htmltools::p(
      htmltools::HTML(
        "Scroll over the table to view additional rows and columns. Click or tap the button below to download a file of the previewed data with tab-separated values."
      ), 
      
      class = "table-caption"
    )
  
  return(tableCaption)
}