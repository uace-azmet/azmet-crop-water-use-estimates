# fxnCalculateETc: estimate daily crop water use based on ETo values
# 
# @param: dAZMetDataELT - AZMet data from `fxnAZMetDataELT.R`
# @param: annualCrop - annual crop selected by user
# @param: growingSeasonLength - growing season length based on annual crop selected by user, defined in `app.R`
# @return: dCalculateETc - AZMet data with daily individual and cummulative ETc values


fxnCalculateETc <- function(dAZMetDataELT, annualCrop, growingSeasonLength) {
  dCalculateETc <- dAZMetDataELT %>%
    dplyr::mutate(days_since_planting = seq(from = 0, to = nrow(dAZMetDataELT) - 1)) %>%
    
    # Assign daily value for crop coefficient based on user input
    dplyr::mutate(kc = purrr::map(.x = days_since_planting, .f = function(.x) {
      if (.x > growingSeasonLength | .x <= 0) {
        NA_real_
      } else {
        cropCoefficientCurves$cropCoefficient[which(
          cropCoefficientCurves$crop == annualCrop & cropCoefficientCurves$growingDay == .x
        )]
      }
    })) %>%
    
    dplyr::mutate(kc = as.numeric(kc)) %>%
    dplyr::mutate(water_use_in = kc * eto_pen_mon_in) %>%
    dplyr::arrange(dplyr::desc(datetime)) %>%
    dplyr::mutate(precip_total_in_cumsum = cumsum(precip_total_in)) %>%
    dplyr::mutate(eto_pen_mon_in_cumsum = cumsum(eto_pen_mon_in)) %>%
    dplyr::mutate(water_use_in_cumsum = cumsum(water_use_in))
  
  return(dCalculateETc)
}