#!/usr/bin/Rscript
#This is code pertinent to Computer Convergence Applications project

require("ggplot2")
require(ggdendro)

# K-Means Clustering
data <- read.csv("voice.csv", header=TRUE, sep=";")
names(data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
#data$label <- as.factor(data$label)
# Load and name data

v <- c(2,3,5,10,20)
x <- data[,c(2,14)]
dist = dist(x)
for (k in v) {
    hc  <- hclust(dist, method = "ward.D2")
    cutcluster <- cutree(hc, k=k)
    d <- cut(as.dendrogram(hc), h=k)
    par(mfrow=c(1, 2))
    plot(d$lower[[1]])
    plot(d$lower[[2]])
    par(mfrow=c(1, 1))
    #ggdendrogram(cutcluster, rotate = TRUE)

    #str=sprintf("ward k=%d.png",k)
    #ggsave(str, width = 5, height = 5)

    ggplot(x, aes(data[,2], data[,14], color =data[,'label'])) + geom_point(alpha = 0.4, size = 3.5) + geom_point(col = cutcluster)
    str=sprintf("compareward k=%d.png",k)
    ggsave(str, width = 5, height = 5)
}

