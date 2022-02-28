##  00-utils: script to run first 

# check if all packages are installed -------------------------------------

requiredPkgs <- 
  c('dplyr', 
    'MatchIt',
    'ggplot2',
    'sandwich',
    'lmtest'
    )

requiredPkgs %in% installed.packages() ## check for FALSE

## action: if any are not installed please install 

