install.packages("heuristica")
install.packages("Rcpp")
install.packages("caret")
library(caret)
install.packages("e1071")
data <- read.csv("voice.csv", header=TRUE, sep=";")
names(data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew", "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun", "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange", "modindx", "label")
data$label <- as.factor(data$label)
table(data$label)

set.seed(365)
s <- sample(nrow(data), 0.66 * nrow(data))
train <- data[s,]
test <- data[-s,]
dtree <-rpart(label ~ meanfreq + sd + median + Q25 + Q75 + IQR + skew + kurt + sp.ent + sfm + mode + centroid + meanfun + minfun + maxfun + meandom + mindom + maxdom + dfrange + modindx, train, method="class")
rpart.plot(dtree)
dtree_pred <- predict(dtree, test, type="class")
confusionMatrix(dtree_pred, test$label)$overall[1]

s2 <- sample(nrow(data), 0.75 * nrow(data))
train2 <- data[s2,]
test2 <- data[-s2,]
dtree2 <-rpart(label ~ meanfreq + sd + median + Q25 + Q75 + IQR + skew + kurt + sp.ent + sfm + mode + centroid + meanfun + minfun + maxfun + meandom + mindom + maxdom + dfrange + modindx, train2, method="class")
rpart.plot(dtree2)
dtree_pred2 <- predict(dtree2, test2, type="class")
confusionMatrix(dtree_pred2, test2$label)$overall[1]

s3 <- sample(nrow(data), 0.8 * nrow(data))
train3 <- data[s3,]
test3 <- data[-s3,]
dtree3 <-rpart(label ~ meanfreq + sd + median + Q25 + Q75 + IQR + skew + kurt + sp.ent + sfm + mode + centroid + meanfun + minfun + maxfun + meandom + mindom + maxdom + dfrange + modindx, train3, method="class")
rpart.plot(dtree3)
dtree_pred3 <- predict(dtree3, test3, type="class")
confusionMatrix(dtree_pred3, test3$label)$overall[1]

s4 <- sample(nrow(data), 0.6 * nrow(data))
train4 <- data[s4,]
test4 <- data[-s4,]
dtree4 <-rpart(label ~ meanfreq + sd + median + Q25 + Q75 + IQR + skew + kurt + sp.ent + sfm + mode + centroid + meanfun + minfun + maxfun + meandom + mindom + maxdom + dfrange + modindx, train4, method="class")
dtree_pred4 <- predict(dtree4, test4, type="class")
confusionMatrix(dtree_pred4, test4$label)$overall[1]
