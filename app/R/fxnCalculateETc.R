# fxnCalculateETc: estimate daily crop water use based on ETo values
# 
# @param: dAZMetDataELT - AZMet data from `fxnAZMetDataELT.R`
# @param: annualCrop - annual crop selected by user
# @param: growingSeasonLength - growing season length based on annual crop selected by user, defined in `app.R`
# @return: dCalculateETc - AZMet data with daily individual and cummulative ETc values


fxnCalculateETc <- function(dAZMetDataELT, annualCrop, growingSeasonLength) {
  dCalculateETc <- dAZMetDataELT %>%
    dplyr::mutate(days_since_planting = seq(from = 0, to = nrow(dAZMetDataELT) - 1)) %>%
    dplyr::mutate(
      kc = dplyr::if_else(
        days_since_planting > growingSeasonLength, NA_real_, dplyr::if_else(
          days_since_planting <= 0, 
          NA_real_, 
          purrr::map_dbl(.x = days_since_planting, .f = function(.x, annualCrop = annualCrop) {
            #.x + 1
            cropCoefficientCurves$cropCoefficient[
              which(cropCoefficientCurves$crop == annualCrop & cropCoefficientCurves$growingDay == .x)
            ]
          })
          #days_since_planting <= 0, NA_real_, fxnAssignKc(days_since_planting))
          #cropCoefficientCurves$cropCoefficient[which(
          #  cropCoefficientCurves$crop == annualCrop & cropCoefficientCurves$growingDay == days_since_planting
          #)]
        )
        #dplyr::if_else(days_since_planting <= 0, NA_real_, 
        #  cropCoefficientCurves$cropCoefficient[
        #    which(
        #      cropCoefficientCurves$crop == annualCrop & 
        #        cropCoefficientCurves$growingDay == days_since_planting
        #    )
        #  ]
    #    )
      )
    ) %>%
        
        #if (days_since_planting > growingSeasonLength) {
        #  kc <- NA
        #} else if (daysSincePlantingDifference <= 0) {
        #  kc <- NA
        #} else {
        #  kc <- cropCoefficientCurves$cropCoefficient[
        #    which(cropCoefficientCurves$crop == inCrop &
        #            cropCoefficientCurves$growingDay == daysSincePlantingDifference)
        #  ]
        #}
        
    #  ) fxnAssignKc(annualCrop = annualCrop, growingSeasonLength = growingSeasonLength)) %>%
    #dplyr::mutate(water_use_in = eto_pen_mon_in * kc)
    dplyr::arrange(dplyr::desc(datetime)) %>%
    dplyr::mutate(precip_total_in_cumsum = cumsum(precip_total_in)) %>%
    dplyr::mutate(eto_pen_mon_in_cumsum = cumsum(eto_pen_mon_in))
  
  return(dCalculateETc)
}
