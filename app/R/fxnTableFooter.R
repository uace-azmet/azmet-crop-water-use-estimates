# fxnTableFooter: Build footer for HTML table based on user input
# 
# @param: annualCrop - annual crop selected by user
# @return: tableFooter - footer for HTML table based on user input


fxnTableFooter <- function(annualCrop) {
  urlReferenceAZMet <- a(
    "api.azmet.arizona.edu", 
    href="https://api.azmet.arizona.edu/v1/observations/daily", 
    target="_blank"
  )
  
  urlReferenceBulletin <- a(
    "Penman-Monteith equation",
    href="https://extension.arizona.edu/pubs/standardized-reference-evapotranspiration-new-procedure-estimating-reference-evapotranspiration",
    target="_blank"
  )
  
  urlReferenceFAO <- a(
    "www.fao.org", 
    href="https://www.fao.org/3/x0490e/x0490e0b.htm", 
    target="_blank"
  )
  
  tableFooter <- 
    htmltools::p(
      htmltools::HTML(
        paste(
          "Evapotranspiration is reference evapotranspiration (",
          em("ETo"),
          ") based on the",
          urlReferenceBulletin, # figure out
          ".",
          "Estimates of water use (",
          em("ETc"),
          ") are based on crop growth stage, crop coefficients (",
          em("Kc"),
          ") and the crop coefficient curve model from",
          urlReferenceFAO, # figure out
          ".",
          "Daily water use is estimated by the formula",
          em("ETc = Kc * ETo"),
          ".",
          "Water use values of 'NA' denote accumulation periods with dates equal to or before the selected planting date or past the 'late-season' growth stage.",
          br(), br(),
          "Based on the selected planting date,",
          annualCrop,
          "is estimated to be",
          "cropGrowthStageText()", # figure out
          ".",
          "Lengths of crop growth stages are based on September, October, and November planting dates.",
          "The time since the planting date is",
          "daysSincePlanting()", # figure out
          "mainCaptionDayText()", # figure out
          ".",
          "The modeled total growing season length for", 
          annualCrop,
          "is",
          "growingSeasonLength()", # figure out
          "days.", 
          br(), br(),
          "AZMet data are from", 
          "urlReferenceAZMet", # figure out
          ".",
          "Recent values are based on provisional data. Users of AZMet data and data applications assume all risks of its use.", 
          br(), br()
        )
      )
    )
  
  return(tableFooter)
}