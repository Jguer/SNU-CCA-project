#!/usr/bin/Rscript
#This is code pertinent to Final Project.

#require(heuristica)
#require(Rcpp)
require(caret)
require(e1071)
require(rpart)
require(rpart.plot)
data <- read.csv("voice.csv", header=TRUE, sep=";")
names(data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
#data$label <- as.factor(data$label)
#table(data$label)

set.seed(3651)
v <- c(0.60, 0.66,0.75,0.80)

for (i in v){
    s <- sample(nrow(data), i * nrow(data))
    train <- data[s,]
    test <- data[-s,]
    dtree <-rpart(label ~ meanfreq + sd + median + Q25 + Q75 + IQR + skew + kurt +
                  sp.ent + sfm + mode + centroid + meanfun + minfun + maxfun +
                  meandom + mindom + maxdom + dfrange + modindx,  train, method="class")

    dtree_pred <- predict(dtree, test, type="class")
    rpart.plot(dtree)
}
