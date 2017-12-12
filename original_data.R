# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(plotly)
library(GGally)

# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory

voice <- read.csv("voice.csv", header=TRUE, sep=";")
names(voice) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")

# Any results you write to the current directory are saved as output.

## Dimension and structure
dim(voice)
names(voice)
str(voice)

## Summary of the dataset
summary(voice)
## Checking the correlation between the variables

# Scatter plot matrices of SD, Median, Mean, Q25, Q75 and IQR
pairs(voice[,c(2,3,4,5,6,14)])


## Using GGally package
ggpairs(voice[,c(2,3,4,5,6,14)])


## Visualizing using ggplot

## how SD and IQR varies among men and women
ggplot(voice, aes(meanfreq, meanfun, color = label)) + geom_point(size = 2) + ggtitle("Mean Freq v/s Mean Fun")
ggsave("sdiqr.png", width = 5, height = 5)
## how Q25 and Q75 varies among men and women
ggplot(voice, aes(Q25, Q75, color = label)) + geom_point(size = 2) + ggtitle("Q25 v/s Q75")
    ggsave("q25q75.png", width = 5, height = 5)
