library(dplyr)
library(MatchIt)

# input -------------------------------------------------------------------

myData <-
  readRDS('data/makefile01 NSW+controls no outcome.rds')

## For NSW the codebook is:
# "idVar" is a random id variable 
# "treat" is the treatment assignment (1=treated, 0=control).
# "re78" is income in 1978, in U.S. dollars. (this is the outcome -- not included at the mo)

# "age" is age in years.
# "education" is education in number of years of schooling.
# "black" individual race/ethnicity is black 
# "hispan" individual race/ethnicity is hispanic
# "married" is an indicator for married (1=married, 0=not married).
# "nodegree" is an indicator for whether the individual has a high school degree (1=no degree, 0=degree).
# "re74" is income in 1974, in U.S. dollars.
# "re75" is income in 1975, in U.S. dollars.


# code --------------------------------------------------------------------


# exact matching using matchit --------------------------------------------
## The command is matchit(); 
# input in data and options
# output is an object from where we can extract our matched data 
# tip: clear your working environment once in a while -- matchit has odd behaviours

?matchit

exactMatch <- 
  matchit(
  treat ~ married + nodegree,
  myData,
  method = 'exact'
  )

## summary at a glance -- exact matching will always produce exact balance 
exactMatch %>% summary

## get out the matched data, including vars you didn't match on
exactData <-
  exactMatch %>% 
  match.data()

## check new vars: weights and subclass
exactData

## check re75 again
lm(re75 ~ treat + subclass, exactData) 
## check the variable for treat has the same value as in script 01
## note: other covariate values are different because our codeing and reference sublass is different

## To get the proper ATT you need to weight
lm(re75 ~ treat, exactData, weights = weights) 

## Shows the estimate in 01 is just an unweighted version 
lm(re75 ~ treat + subclass, exactData) 
lm(re75 ~ treat + subclass, exactData, weights = weights) 


## Note that once reweighted the sample is balanced with respect to married and nodegree
##  adding these variables in no logner affect results
## i.e. doubly robust
lm(re75 ~ treat + married + nodegree, exactData, weights = weights) 
lm(re75 ~ treat + nodegree, exactData, weights = weights) 
lm(re75 ~ treat + nodegree*married, exactData, weights = weights) 


# exact matching with continuous variables --------------------------------
exactMatch_tooMuch <- 
  matchit(
    treat ~ married + nodegree + age + education,
    myData,
    method = 'exact'
  )

## you might lose too many cases 
exactMatch_tooMuch %>% summary

## note how many unique combinations of the 4 variables there are 
match.data(exactMatch_tooMuch) %>% summary
## there's 461+ subclass

## Still doubly robust 
exactData_tooMuch <- exactMatch_tooMuch %>% match.data()

lm(re75 ~ treat, exactData_tooMuch, weights = weights) 
lm(re75 ~ treat + nodegree*married, exactData_tooMuch, weights = weights) 
lm(re75 ~ treat + age, exactData_tooMuch, weights = weights) 
lm(re75 ~ treat + age + I(age^2), exactData_tooMuch, weights = weights) 
lm(re75 ~ treat + age + I(age^2 * education), exactData_tooMuch, weights = weights) 
# ^ treat has the same results (minus rounding) no matter model functional form

# coarsened exact matching (CEM) ------------------------------------------

cemMatch <- 
  matchit(
    treat ~ married + nodegree + age + education,
    myData,
    method = 'cem'
  )

## rougher matches than exact matching
cemMatch %>% summary

## still tones of subclass (more cases included)
match.data(cemMatch) %>% summary



# Propensity score --------------------------------------------------------

psmLogitMatch <- 
  matchit(
    treat ~ married + nodegree + age + education,
    myData,
    method = 'nearest', # the default
    distance = 'glm' # also default
  )

## new var distance is the distance is the summary of the propensity score
psmLogitMatch %>% summary

psmLogitData <-
  psmLogitMatch %>% 
  match.data()

## check
# distance = distance measure -- in this case the propensity score 
psmLogitData %>% head

## subclass is the pair of matched treatment and control cases 
psmLogitData$subclass

## notes here: each subclass has 2 cases
psmLogitData %>%
  arrange(
    subclass
  )


## again using re75 in a regression 
lm(re75 ~ treat, psmLogitData, weights = weights)
## For 1:! matching, this is the same getting the average difference in re75 between matched pairs

## if balance is achieved then adding the matching covars should not really change the results
lm(re75 ~ treat + married + nodegree + age + education, psmLogitData, weights = weights)
lm(re75 ~ treat + married*(nodegree + age + education), psmLogitData, weights = weights)
lm(re75 ~ treat + married + nodegree + age + I(age^2) + education + I(education^2), psmLogitData, weights = weights)
## could be better, could be worse; see below

# unmatched data ----------------------------------------------------------
## Do estimates fluctuate for the non-processed raw data? 
lm(re75 ~ treat + married + nodegree + age + education, myData)
lm(re75 ~ treat + married*(nodegree + age + education), myData)
lm(re75 ~ treat + married + nodegree + age + I(age^2) + education + I(education^2), myData)

## Context 
lm(re75 ~ treat + married + nodegree + age + education, myData) %>% summary
## Estimate fluctuate 1SE simply based on our choice of functional form