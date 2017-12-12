# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(randomForest)
# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory

voice <- read.csv("voice.csv")
# Any results you write to the current directory are saved as output.
## Creating training and testing data from the dataset
index <- sample(2, nrow(voice),  replace = TRUE, prob = c(0.7, 0.3))
train <- voice[index==1, ]
test <- voice[index==2, ]
dim(test)
test_labels <- voice[index==2, 21]
label <- voice[index==21]

## creating the model
model <- randomForest(label ~ ., data = train)
print(model)
print(model$confusion)

## Predicting using the test dataset
predictions <- predict(model, newdata = test)
table(predictions)

## Table of actual against predicted
table(test_labels, predictions)

## Accuracy
(481 + 471) / nrow(test)
