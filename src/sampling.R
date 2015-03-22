# Diego, March 2015.

setwd(paste0("~/Sync/Dropbox/R/Coursera/",
    "6 Statistical Inference/Project/src"))
library(ggplot2)
library(dplyr)

lambda <- 0.2
size   <- 40
reps   <- 1000


# Density of X
png("../output/Exp Density.png")
ggplot(data.frame(x=c(0,20)), aes(x)) +
  stat_function(fun=function(x)dexp(x,lambda), geom="line") +
  labs(title=expression("Density of"~X), y=expression(f(x))) +
  geom_vline(xintercept=1/lambda, color="blue")
nil <- dev.off()


# Two samples of X and their mean
xsample <- rexp(reps+size, lambda)
xsmplDF <- data.frame(x=xsample,
    n=c(rep(size,size), rep(reps,reps)))
by_n <- xsmplDF %>% group_by(n) %>% summarize(Mean=mean(x))

png("../output/Exp Histograms.png")
ggplot(xsmplDF, aes(x)) +
    geom_histogram(binwidth=1.5, alpha=0.8) +
    facet_wrap(~ n, scales='free_y') +
    labs(title=expression("Sample Histograms of"~X),
        y=expression("#"(x))) +
    geom_vline(data=by_n, mapping=aes(xintercept=Mean),
        color="green3")
nil <- dev.off()


# 1000 samples of X_bar.
expSim <- rexp(size*reps, lambda)
expMat <- matrix(expSim, nrow=size, ncol=reps)

meansDF <- data.frame(x_bar=apply(expMat, 2, mean))

png("../output/Exp_Bar Histogram.png")
ggplot(meansDF, aes(x_bar)) +
    geom_histogram(binwidth=0.2, alpha=0.8) +
    labs(title=expression("Sample Histogram of"~bar(X)[n]),
        y=expression("#"(x)), x="x") +
    geom_vline(data=meansDF, mapping=aes(xintercept=mean(x_bar)),
        color="red3")
nil <- dev.off()



bar <- ggplot(meansDF, aes(x=x_bar)) +
    geom_histogram(aes(y = ..density..), binwidth=0.2,
        alpha=0.8) +
    geom_vline(aes(xintercept=mean(x_bar)), color="red3") +
    stat_function(color="green3", fun=function(x)
        dnorm(x,1/lambda,1/lambda/sqrt(size))) +
    labs(title="Density vs. Histogram",
        y=expression(f(x)), x="x")

png("../output/HistogramDensity.png")
print(bar)
nil <- dev.off()















