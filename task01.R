##  task 1: NSW 

## Try to read in the NSW data and calculate the treatment effect 
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

## Outcome file; re78
nsw_onlyOut <-
  readRDS('data/makefile01 NSW+controls outcomes only.rds')


# setup data --------------------------------------------------------------

myNSW <-
  nsw_noOut %>%
  left_join(nsw_onlyOut)

# code example ------------------------------------------------------------

# my example 
myNSW %>% head
## least squares
lm(re78 ~ treat, myNSW) %>% summary # ~ -15k
lm(re78 ~ treat + age + education + black + hispanic + married + nodegree, myNSW) %>% summary # -6.4k
lm(re78 ~ treat + age + education + black + hispanic + married + nodegree + re75, myNSW) %>% summary # -1.5k

# DiD
lm(I(re78 - re75) ~ treat + age + education + black + hispanic + married + nodegree, myNSW) %>% summary # -52


