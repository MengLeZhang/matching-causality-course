##  04. Estimation and standard errors 


# input -------------------------------------------------------------------
## get your data -- this example I use data from template02

nsw_matchitSavedData %>% names ## heres all the matched data names
nsw_matchitSavedData$exact ## how to access the matched data 

library(lmtest)
library(sandwich)

# code --------------------------------------------------------------------

## At this point we can join our data with the outcomes
nsw_onlyOut <-
  readRDS('data/makefile01 NSW+controls outcomes only.rds')

## join the data
nsw_matchitSavedData$exact <-
  nsw_matchitSavedData$exact  %>% left_join(nsw_onlyOut)

nsw_matchitSavedData$cem <-
  nsw_matchitSavedData$cem  %>% left_join(nsw_onlyOut)

nsw_matchitSavedData$psm1 <-
  nsw_matchitSavedData$psm1  %>% left_join(nsw_onlyOut)


# simple difference in mean outcomes --------------------------------------

# exact matching ----------------------------------------------------------
## use ols
## ALWAYS use weights
## generally you want to include all the matching covariates you used 
## Except for exact matching
## wages in 1978 is our outcome

exactFit1 <-
  lm(
    re78 ~ treat,
    weights = weights,
    data = nsw_matchitSavedData$exact 
    )

exactFit1 %>% summary ## we want the estimate for treat but the standard errors will be wrong
## For exact matching using robust standard errors (not clustered SE)
## This is to adjust the weights 
exactCoef1 <-
  coeftest(exactFit1, 
           vcov. = vcovHC
  )
exactCoef1

# coarsened exact ---------------------------------------------------------
cemFit1 <-
  lm(
    re78 ~ treat + age + education + black + hispanic + married + nodegree,
    weights = weights,
    data = nsw_matchitSavedData$cem
  )


## It's best to use cluster standard errors by subclass 
cemFit1%>% summary 
## for cem and psm, we ideally want to cluster by subclass
cemCoef1 <-
  coeftest(cemFit1, 
         vcov. = vcovCL,
         cluster = nsw_matchitSavedData$cem$subclass #<- get the cluster variable from the original data
         )

cemCoef1
# psm ---------------------------------------------------------------------
psmFit1 <-
  lm(
    re78 ~ treat + age + education + black + hispanic + married + nodegree,
    weights = weights,
    data = nsw_matchitSavedData$psm1
  )

psmFit1%>% summary 
## for cem and psm, we ideally want to cluster by subclass
psmCoef1 <-
  coeftest(psmFit1, 
           vcov. = vcovCL,
           cluster = nsw_matchitSavedData$psm1$subclass
  )


# difference-in-difference ------------------------------------------------
psmFit2 <-
  lm(
    I(re78 - re75) ~ treat + age + education + black + hispanic + married + nodegree,
    weights = weights,
    data = nsw_matchitSavedData$psm1
  )

## for cem and psm, we ideally want to cluster by subclass
psmCoef2 <-
  coeftest(psmFit2, 
           vcov. = vcovCL,
           cluster = nsw_matchitSavedData$psm1$subclass
  )


## What SE to use? When in doubt use cluster SE except for exact matching 


# big table of results ----------------------------------------------------
library(stargazer)

## great but wrong SE
stargazer(
  exactFit1,
  cemFit1,
  psmFit1,
  type = 'text')

## Input see from the output of coeftest
exactCoef1 ## this is a table and SE are on col 2

stargazer(
  exactFit1,
  cemFit1,
  psmFit1,
  psmFit2,
  se = 
    list(
      exactCoef1[,2], 
      cemCoef1[,2],
      psmCoef1[, 2],
      psmCoef2[,2]),
  type = 'text')

