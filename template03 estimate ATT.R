# template04: estimation --------------------------------------------------
## boiler plate code for statistical estimation



# input -------------------------------------------------------------------
## checklist:
##  1. get matched data (see template01 and the examples in template01b) 
##  2. input the outcome equation below (thisFormula); include the variables you used for matching
##  3. check that your outcome is actually joined to your matched data 
##  note: you'll want to keep the outcome separate until the end (in theory)

matchedData <- 
  NULL
thisFormula <- 
  NULL # add covariate/ change outcome or do whatever

## find and replace these object names
## 

##  Error if missing 
if(is.null(matchedData)|is.null(thisFormula)){stop('fill in data and formula')}



# code for outcome -------------------------------------------------------

outFit <-
  lm(
    thisFormula,
    weights = weights,
    data = matchedData 
  )

## calculate SE
outFitCoef <-
  coeftest(
    outFit, 
#   vcov. = vcovHC #<- robust SE for exact matching 
#   vcov. = vcovCL, cluster = matchedData$subclass #<- cluster SE for almost everything else
  )

## if in doubt consult cheatsheet / matching vignette 
##  Also remember: at the end of the day most SE are wrong anyway 


# table for results? ------------------------------------------------------
library(stargazer)

stargazer(
  NULL, #<- model 1 here : e.g. outFit
  NULL, #<- model 2
  NULL, #<- model 3 etc
  se = 
    list(
      NULL, #<- insert SE for model one from coeftest (e.g. outFitCoef[,2])
      NULL, #<- SE model 2
      NULL #<- etc
    ),
  type = 'text')

