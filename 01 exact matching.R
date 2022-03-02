
library(dplyr)
library(MatchIt)

# input -------------------------------------------------------------------

nsw_noOut <-
  readRDS('data/makefile01 NSW+controls no outcome.rds')
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



# code example ------------------------------------------------------------

## Exact matching 

## Create the subclass/strata indicator  
## say we want to match on marital status and whether whether they have a degree

## paste0 stick two string together: 'A', 'B' becomes 'AB'
nsw_noOut <-
  nsw_noOut %>% 
  mutate(
    subclass = paste0(married, nodegree) %>% as.character()
  )

## Check out the sample size in each subclass
nsw_noOut %>%
  group_by(
    subclass, married, nodegree, treat
  ) %>%
  summarise(
    n = n()
  )

## For each subclass we can calculate the difference in mean ....
## say of earnings in re75

lm(re75 ~ treat, nsw_noOut, subset = subclass == '00') # -13218
lm(re75 ~ treat, nsw_noOut, subset = subclass == '01') # -6589
lm(re75 ~ treat, nsw_noOut, subset = subclass == '10') # -16303
lm(re75 ~ treat, nsw_noOut, subset = subclass == '11') # -10566

## so forth.... then 

## Work out the ATT by hand:
## Step 1: Get each subclass effect 
## Step 2: Get the weighted average of the effect (subclass effect * prop(in subclass| treated))  

## Step 1.
## For each subclass we can calculate the difference in mean ....
## say of earnings in re75

lm(re75 ~ treat, nsw_noOut, subset = subclass == '00') # -13218
lm(re75 ~ treat, nsw_noOut, subset = subclass == '01') # -6589
lm(re75 ~ treat, nsw_noOut, subset = subclass == '10') # -16303
lm(re75 ~ treat, nsw_noOut, subset = subclass == '11') # -10566


## Step 2. 
## Find the proportion of people in each subclass (treatment group only)
nsw_noOut$treat %>% table
nsw_noOut %>%
  filter(treat == 1) %>%
  group_by(
    subclass
  ) %>%
  summarise(
    prop = n() / 297
  )

(-13218 * 0.226) + (-6589 * 0.606) + (-16303 * 0.0438) + (-10566 *0.125)
## approx -9015 


## Warning: Just wacking the subclasses into a model isn't wrong per se -- 
##  it just doesn't give you the ATT
lm(re75 ~ treat + subclass, nsw_noOut) 
## the weight will be off here: this is more like the ATE

## Clearly this is a pain; let's use a proper matching package.
