# 03 checking balance -----------------------------------------------------


# input -------------------------------------------------------------------
## run script 02 and let's look at the propensity score object
## clarity rename the object 

checkThisMatchit <-
  psmLogitMatch

checkThisData <-
  psmLogitData


# code --------------------------------------------------------------------

##  Check diff in means and variance ratio 
## eCDF mean and eCDF max 
checkThisMatchit %>%
  summary
## aim for:
# var ratio equal to 1 
# std mean diff = 0
# eCDF and eCDF max = 0 

# visual check 
## overall check of diff in standardised means; you want it lines = 0.1 and 0.05 
## you want within this area
checkThisMatchit %>%
  summary %>%
  plot(abs = F)



## raw data EQQ: for scale data you want a straight line
checkThisMatchit %>%
  plot(type = 'qq')

## ecdf: look for same shape
checkThisMatchit %>%
  plot(type = 'ecdf')

## Others:
checkThisMatchit %>%
  plot(
    type = 
      # 'qq'
      # 'ecdf'
      # 'density'
      # 'jitter'
      'histogram'
    )

##  love plots to summarise everythin
checkThisMatchit %>%
  summary %>%
  plot(var.order = 'unmatched', abs = F)


## plots 
## eQQ plots -- for scale vars you want a straight line


# what does perfect balance look like -------------------------------------
## exact matching guarantees balance (based on matched vars)

exactMatch <- 
  matchit(
    treat ~ age + education,
    myData,
    method = 'exact'
  )

## this is what we get 
exactMatch %>% summary
exactMatch %>% plot

## get the data
exactData <-
  exactMatch %>% 
  match.data()


# visual checks -----------------------------------------------------------

## one variable at a time : kernel plots

library(ggplot2)
checkThisData %>% summary

## boxplots
ggplot(checkThisData, aes(x = age,group = treat, colour = treat)) +
  geom_boxplot()
  
## density plots 
ggplot(checkThisData, aes(x = age, group = treat, colour = treat)) +
  geom_density(y = 'identity')

## histogram

ggplot(checkThisData, aes(x = age, group = treat, colour = treat)) +
  geom_histogram(aes(y=..density..) )


## what to do with 1 to many matches (i.e. in the case of exact matching)
ggplot(exactData, aes(x = age, group = treat, colour = treat)) +
  geom_density()

## i.e the control group has weights 
exactData %>% summary

## For ggplot add in weights  
ggplot(exactData, 
       aes(x = age, group = treat, 
           colour = treat,
           weight = weights) ## <- this here
       ) +
  geom_density()

ggplot(exactData, 
       aes(x = age, group = treat, 
           colour = treat,
           weight = weights) ## <- this here
  ) + 
  geom_histogram(aes(y=..density..) )
  

# pairwise ----------------------------------------------------------------

library(GGally)

## pairwise plots 
ggpairs(
  data = checkThisData %>% select(treat, married, nodegree, age, education), # <- don't put in everything (no id variables for example)
  ggplot2::aes(colour = treat %>% as.factor) # <- make sure your treatment indicator is a character/factor
  )

## you might want to wrangle some data (i.e. make nodegree a factor not a 1 or 0)
ggpairs(
  data = 
    checkThisData %>% 
    mutate(
      treat = treat %>% as.factor, 
      married = married %>% as.factor,
      nodegree = nodegree %>% as.factor
      ) %>%
    select(treat,  age, education),
  ggplot2::aes(colour = treat) # <- make sure your treatment indicator is a character/factor
)

## Checkout the help page for GGally for more options

## Example using exact matching
ggpairs(
  data = 
    exactData %>% 
    mutate(
      treat = treat %>% as.factor, 
      education = education %>% as.factor ## is a bit funky here
    ) %>%
    select(treat, age, education, weights),
  ggplot2::aes(colour = treat, weight = weights) # <- make sure your treatment indicator is a character/factor
)


# more than 2 variables ---------------------------------------------------

## try splitting the data into subsets and checking 
## Check by married only
ggpairs(
  data = 
    checkThisData %>% 
    filter(married == 1) %>%
    mutate(
      treat = treat %>% as.factor, 
      married = married %>% as.factor,
      nodegree = nodegree %>% as.factor
    ) %>%
    select(treat, married, nodegree, age, education),
  ggplot2::aes(colour = treat) # <- make sure your treatment indicator is a character/factor
)

## check for unmarried 
ggpairs(
  data = 
    checkThisData %>% 
    filter(married == 0) %>%
    mutate(
      treat = treat %>% as.factor, 
      married = married %>% as.factor,
      nodegree = nodegree %>% as.factor
    ) %>%
    select(treat, married, nodegree, age, education),
  ggplot2::aes(colour = treat) # <- make sure your treatment indicator is a character/factor
)

## This will get out of hand very quickly

