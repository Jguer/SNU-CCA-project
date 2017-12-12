# Including library
library(rpart)
library(rpart.plot)
library(randomForest)

# Import Data
voice_data <- read.csv("voice.csv", header=TRUE, sep=";")
names(voice_data) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
voice_data$label <- as.factor(voice_data$label)

# Information about Dataset
summary(voice_data)
dim(voice_data)

# Prepare PCA
label_col <- which(colnames(voice_data) == "label")

# Perform PCA
voice_pca <- prcomp(voice_data[,2:21])
summary(voice_pca)
biplot(voice_pca, col = c("red", "blue"), scale = 0)

