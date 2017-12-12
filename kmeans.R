#!/usr/bin/Rscript
#This is code pertinent to Computer Convergence Applications project

require("ggplot2")

# K-Means Clustering
data <- read.csv("voice.csv", header=TRUE, sep=";")
names(data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
data$label <- as.factor(data$label)
# Load and name data

k <- 2
kc <- kmeans(data[,2:21], k)
table(kc$cluster, data[,22])

ggplot(data[,2:9], aes(data[,'meanfreq'], data[,'meanfun'], color =
                       kc$cluster)) + geom_point() + labs(title ="K-means
clustering", x ="meanfreq", y = "meanfun")
ggsave("kmeans.png", width = 5, height = 5)

ggplot(data[,2:9], aes(data[,'meanfreq'], data[,'meanfun'], color =
                       data[,'label'])) + geom_point() + labs(title ="Original
Classes", x ="meanfreq", y = "meanfun")
ggsave("original.png", width = 5, height = 5)
