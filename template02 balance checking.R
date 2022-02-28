# boilerplate template for checking ---------------------------------------


# input -------------------------------------------------------------------
## list of saved matchit models and their data 
## example: run template02 and get the models
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

checkThisMatchit %>%
  plot(
    type = 
      # 'qq'
      # 'ecdf'
      # 'density'
      # 'jitter'
      # 'histogram'
  )

checkThisMatchit %>%
  summary %>%
  plot(
    abs = F
    )

# 3. pairwise plots -------------------------------------------------------

## No boilerplate here (unless you want to write your own for loop)

ggpairs(
  data = 
    checkMatchitData$exact %>% 
    mutate(
      treat = treat %>% as.factor, 
      married = married %>% as.factor,
      nodegree = nodegree %>% as.factor
    ) %>%
    select(treat, married, nodegree, age, education),
  ggplot2::aes(colour = treat) # <- make sure your treatment indicator is a character/factor
)

