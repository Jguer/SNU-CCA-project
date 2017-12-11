setwd("~/Desktop/TermProjConv/")

# Including library
library(rpart) 
library(rpart.plot) 
library(randomForest)

# Import Data
voice_data <- read.csv("voice.csv", header=TRUE, sep=";")
names(dat) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew", "kurt", "sp.ent", "sfm	", "mode", "centroid", "meanfun", "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange", "modindx"	label)

# Information about Dataset
summary(voice_data)
dim(voice_data)

# Prepare PCA
label_col <- which(colnames(voice_data) == "label")

# Perform PCA
voice_pca <- prcomp(voice_data[, -label_col]) 
summary(voice_pca)
biplot(voice_pca, col = c("red", "blue")) 


# Decission Tree

# Splitting dataset
set.seed(1234)
s <- sample(nrow(dat), 0.7*nrow(dat))
train_data <- dat[s,]
test_data <- dat[-s,]

# building decision tree model
dtree <-rpart(class ~ )