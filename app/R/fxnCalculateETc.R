# fxnCalculateETc: estimate daily crop water use based on ETo values
# 
# @param: azmetData - AZMet data from `fxnAZMetDataELT.R`
# @param: annualCrop - annual crop selected by user
# @param: growingSeasonLength - growing season length based on annual crop selected by user, defined in `app.R`
# @return: data - AZMet data with daily individual and cummulative ETc values


fxnCalculateETc <- function(azmetData, annualCrop, growingSeasonLength) {
  
  azmetData <- azmetData %>%
    dplyr::mutate(days_since_planting = seq(from = 0, to = nrow(azmetData) - 1)) %>%
    dplyr::mutate(kc = fxnAssignKc(data = .data, annualCrop = input$annualCrop)) %>%
    dplyr::mutate(water_use_in = eto_pen_mon_in * kc)
  #  dplyr::arrange(dplyr::desc(datetime)) %>%
  #  dplyr::mutate(precip_total_in_cumsum = cumsum(precip_total_in))
  
  
  if (.data$days_since_planting > inGrowingSeasonLength) {
    kc <- NA
  } else if (daysSincePlantingDifference <= 0) {
    kc <- NA
  } else {
    kc <- cropCoefficientCurves$cropCoefficient[
      which(cropCoefficientCurves$crop == inCrop &
              cropCoefficientCurves$growingDay == daysSincePlantingDifference)
    ]
  }
  
  return(azmetData)
}