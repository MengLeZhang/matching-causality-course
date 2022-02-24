## makeFile 01 clean the NSW data and split the wages 

library(dplyr)
library(haven)

## 1. Load in the data 

nswRaw <- 
  read_dta('data/nsw.dta')

psidRaw <-
  read_dta('data/psid_controls.dta')


## 2. combine the data 

allCombine <-
  nswRaw %>% bind_rows(psidRaw)

## 3. add id variables 
set.seed(123)

allCombine <-
  allCombine %>%
  mutate(
    idVar = sample.int(1e5, size = nrow(allCombine))
  )

## 4. create sample 1) no NSW controls and 2) separate outcome 

noRCT <- 
  allCombine %>%
  filter(
    !(treat == 0 & data_id == 'Lalonde Sample')
  )

re78Only <- 
  noRCT %>%
  select(idVar, re78)

noOut <- 
  noRCT %>%
  select(-data_id, -re78)

## save 
saveRDS(noOut, 'data/makefile01 NSW+controls no outcome.rds')
saveRDS(re78Only, 'data/makefile01 NSW+controls outcomes only.rds')

## 5. The full RCT data 

allCombine %>%
  saveRDS(
    'data/makefile01 NSW complete.rds'
  )



