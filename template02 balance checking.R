# boilerplate template for checking ---------------------------------------

library(dplyr)
library(MatchIt)
library(GGally)
library(ggplot2)
# input -------------------------------------------------------------------
## list of saved matchit models and their data 
## example: run template01b and get the models
checkMatchit <- 
  nsw_matchitList #example

checkMatchitData <-
  nsw_matchitSavedData #example


# template ----------------------------------------------------------------
## Remember: A list object contains objects within it -- much like how a 
##  dataframe contains variables 

## we can apply one function to each member of a list at a time using:
##  1. lapply
##  2. for loops

## 1. Checks for balance stats for every model
checkMatchit %>% lapply(summary)
# checkMatchit %>% lapply(plot) # tip: hit enter to cycle plots. do not run unless you want to


## 2. Output visuals
## Example
checkThisMatchit <- checkMatchit$psm1

checkThisMatchit %>%
  summary %>%
  plot(
    abs = F
  )

checkThisMatchit %>%
    plot(
      type = 
        # 'qq'
        # 'ecdf'
        # 'density'
        # 'jitter'
        # 'histogram'
    )

# 3. pairwise plots -------------------------------------------------------

## No boilerplate here 
## Check out 03 for example usage of GGally