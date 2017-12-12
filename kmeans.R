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

v <- c(2,3,5,10,20)
x <- data[,c(2,14)]

for (k in v) {
    kc <- kmeans(x, k)
    #table(kc$cluster, x)

    ggplot(x, aes(data[,'meanfreq'], data[,'meanfun'], color =
                           kc$cluster)) + geom_point() + labs(title ="K-means
    clustering", x ="meanfreq", y = "meanfun")
    str=sprintf("kmeans k=%d.png",k)
    ggsave(str, width = 5, height = 5)

}

