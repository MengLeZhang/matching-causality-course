##  template01: match the data 
## boilerplate template for just matching data

# input -------------------------------------------------------------------
## replace with your data
myData <-
  readRDS('data/makefile01 NSW+controls no outcome.rds')


# code --------------------------------------------------------------------

## setup: initiate list of matches and saved matched data
## put this section at the start of your script (once only)
## note: if you change the name of the matchitList and matchitSavedData, change it elsewhere too
  

matchitList <-
  list()

matchitSavedData <-
  list()

# boilerplate matching code -----------------------------------------------
## Instruction: 
## 1. Fill in the modelName with a sensible object name (default: 'someName')
## 2. Fill in the formula below
## 3. Fill in the matching options -- delete as appropriate (check cheatsheet). 
## Note: leave most options blank to use defaults
## 4. Run code and copy+paste the boilerplate template if you want to add more models

modelName <- 'someName' # insert model name
modelName_form <- treat ~ 1 # insert model formula


## Run the rest
print(paste('Running',modelName))
matchitList[[modelName]] <-
  matchit(
    formula = modelName_form, ## add here
    
    ## Exact matching options
    #  method = 'exact', #uncomment/delete as appropriate

    ## Coarsened exact 
    #  method = 'cem', #uncomment/delete as appropriate
    #  discard = 'both', #discard due to lack of common support? treat/control/both/none
    
    ## Propensity score
    ##  1. Pick how to generate the propensity score
    #  distance = 'glm',  ## default
    ##  2. Pick matching method
    #   method = 'nearest', ## default
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

# example usage -----------------------------------------------------------
# checkout template02 
# model1 --------------------------------------------------------------

## Example: exact matching
modelName <- 'exact1' # insert model name
modelName_form <- treat ~ married + nodegree # insert model formula

print(paste('Running',modelName))
matchitList[[modelName]] <-
  matchit(
    formula = modelName_form, ## add here
    
    # Exact matching options
      method = 'exact', #uncomment/delete as appropriate
    data = myData 
  )

matchitSavedData[[modelName]] <-
  matchitList[[modelName]] %>%
  match.data()

print(paste(modelName, 'done: check for errors'))
