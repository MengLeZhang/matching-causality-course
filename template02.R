## template02: example of trying out various methods 
## uses code from 01

# input -------------------------------------------------------------------
## replace with your data
myData <-
  readRDS('data/makefile01 NSW+controls no outcome.rds')

head(myData) 
# code --------------------------------------------------------------------

## setup: initiate list of matches and saved matched data
## put this section at the start of your script (once only)
## note: if you change the name of the nsw_matchitList and nsw_matchitSavedData, change it elsewhere too


nsw_matchitList <-
  list()

nsw_matchitSavedData <-
  list()


# exact matching ----------------------------------------------------------


modelName <- 'exact' # insert model name
modelName_form <- treat ~ age + education + black + hispanic + married + nodegree # insert model formula


## Run the rest
print(paste('Running',modelName))
nsw_matchitList[[modelName]] <-
  matchit(
    formula = modelName_form, ## add here
    
    ## Exact matching options
      method = 'exact', #uncomment/delete as appropriate
    
    data = myData 
  )

nsw_matchitSavedData[[modelName]] <-
  nsw_matchitList[[modelName]] %>%
  match.data()

print(paste(modelName, 'done: check for errors'))


# cem ---------------------------------------------------------------------
modelName <- 'cem' # insert model name
modelName_form <- treat ~ age + education + black + hispanic + married + nodegree  # insert model formula


## Run the rest
print(paste('Running',modelName))
matchitList[[modelName]] <-
  matchit(
    formula = modelName_form, ## add here

    ## Coarsened exact 
    #  method = 'cem', #uncomment/delete as appropriate
    #  discard = 'both', #discard due to lack of common support? treat/control/both/none
    data = myData 
  )

matchitSavedData[[modelName]] <-
  matchitList[[modelName]] %>%
  match.data()

print(paste(modelName, 'done: check for errors'))


# propensity score 1 ------------------------------------------------------


modelName <- 'psm1' # insert model name
modelName_form <- treat ~ age + education + black + hispanic + married + nodegree  # insert model formula


## Run the rest
print(paste('Running',modelName))
matchitList[[modelName]] <-
  matchit(
    formula = modelName_form, ## add here

    ## Propensity score
    ##  1. Pick how to generate the propensity score
      distance = 'glm',  ## default
    ##  2. Pick matching method
       method = 'nearest', ## default
    ## 3. pick other option such as number of matches and calipers
    #   replace = F, # default -- FALSE = use only each match once  
    #   caliper = 0.2, std.caliper = T, # caliper options 
    #   ratio = 4, # how many control units (max)
    #   discard = 'both', #discard due to lack of common support? treat/control/both/none
    
    data = myData 
  )

matchitSavedData[[modelName]] <-
  matchitList[[modelName]] %>%
  match.data()

print(paste(modelName, 'done: check for errors'))

