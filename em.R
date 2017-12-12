# Including library
library(EMCluster, quietly = TRUE)
library(MASS, quietly = TRUE)

voice_data <- read.csv("voice.csv", header=TRUE, sep=";")
names(voice_data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
#voice_data$label <- as.factor(voice_data$label)

## Not run:
set.seed(1234)

#x <- voice_data[,2:21]
x <- as.matrix(voice_data[,2:21])
#v <- c(2,3,5,10,20)
v <- c(3)

for (k in v) {
    ret <- em.EM(x, nclass = k)
    #ret.1 <- starts.via.svd(x, nclass = k, method = "em")
    #summary(ret.1)

    plotmd(x, ret$class)
}
