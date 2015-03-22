# Diego, March 2015

library(datasets)
data(ToothGrowth)

toothData <- ToothGrowth %>% mutate(ID = rep(1:10,6)) %>%
    dcast(ToothGrowth, ID ~ dose + supp, value.var="len")

