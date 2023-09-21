# fxnTableSubtitle: Build subtitle for HTML table based on current date
# 
# @return: tableSubtitle - subtitle for HTML table based on current date


fxnTableSubtitle <- function() {
  tableSubtitle <- 
    htmltools::p(
      htmltools::HTML(
        paste(
          "From", 
          gsub(" 0", " ", format((Sys.Date() - 7), "%B %d, %Y")), 
          "through", 
          gsub(" 0", " ", format((Sys.Date() - 1), "%B %d, %Y")), 
          
          sep = " "
        )
      ), 
      
      class = "table-subtitle"
    )
  
  return(tableSubtitle)
}