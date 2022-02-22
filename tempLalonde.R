library(tidyverse)

nsw <- 
  haven::read_dta('data/nsw.dta')


nsw %>% 
  group_by(treat) %>%
  summarise_all(
    mean
  )
## For this sample effect size is 5976 - 5090

psid <- 
  haven::read_dta('data/psid_controls.dta')

psid

combined <-
  bind_rows(
    nsw %>% filter(treat == 1),
    psid 
  )

combined %>% 
  group_by(treat) %>%
  summarise_all(
    mean
  )
combined 

lm(I(re78 - re75) ~ treat, combined ) %>% summary

lm(I(re78 - re75) ~ treat + age+ education + black + hispanic + nodegree, combined) %>% summary

lm(I(re78 - re75) ~ treat + age+ education + black + hispanic + nodegree, combined) %>% summary

lm(I(re78 - re75) ~ treat + age+ education + black + hispanic + nodegree, combined, subset = re75 > 0) %>% summary

lm(I(re78) ~ treat + age+ education + black + hispanic + nodegree + re75, combined) %>% summary

lm(I(re78) ~ treat + age+ education + black + hispanic + nodegree + re75, combined, subset = re75 > 0) %>% summary
