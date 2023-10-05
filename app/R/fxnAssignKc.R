# fxnAssignKc: assign daily crop coefficient values based on user input
# 
# @param: azmetStation - AZMet station selected by user
# @return: tableSubtitle - subtitle for HTML table based on current date


fxnAssignKc <- function(days_since_planting) {
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
  dKc <- 2 * days_since_planting
  return(dKc)
}