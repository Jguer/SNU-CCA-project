# Including library
#library(rpart)
#library(rpart.plot)
#library(randomForest)
library(FactoMineR)

voice_data <- read.csv("voice.csv", header=TRUE, sep=";")
names(voice_data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
#voice_data$label <- as.factor(voice_data$label)

# Information about Dataset
summary(voice_data)
dim(voice_data)


result <- PCA(voice_data[,2:21]) # graphs generated automatically

library(nFactors)
ev <- eigen(cor(voice_data[,2:21])) # get eigenvalues
ap <- parallel(subject=nrow(voice_data[,2:21]),var=ncol(voice_data[,2:21]),
  rep=100,cent=.05)
nS <- nScree(x=ev$values, aparallel=ap$eigen$qevpea)
plotnScree(nS)
# Import Data
# Prepare PCA
#label_col <- which(colnames(voice_data) == "label")

# Perform PCA
#voice_pca <- prcomp(voice_data[,2:21])
#summary(voice_pca)
#biplot(voice_pca, col = c("red", "blue"), scale = 0)

