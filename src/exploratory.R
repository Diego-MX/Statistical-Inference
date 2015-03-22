# Diego, March 2015

library(dplyr)
library(reshape2)
library(datasets)
library(graphics)
data(ToothGrowth)

toothData <- mutate(ToothGrowth, ID = rep(1:10,6))

png("../output/ToothGrowth.png")
coplot(len ~ dose | supp, data = ToothGrowth,
    panel = panel.smooth, xlab = paste("ToothGrowth data:",
    "length vs dose, given type of supplement"))
nil <- dev.off()


# Tests

