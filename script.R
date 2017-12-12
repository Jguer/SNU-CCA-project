# This R environment comes with all of CRAN preinstalled, as well as many other helpful packages
# The environment is defined by the kaggle/rstats docker image: https://github.com/kaggle/docker-rstats
# For example, here's several helpful packages to load in 

library(ggplot2) # Data visualization
library(readr) # CSV file I/O, e.g. the read_csv function
library(factoextra)
library(gridExtra)
library(gtools)

# Input data files are available in the "../input/" directory.
# For example, running this (by clicking run or pressing Shift+Enter) will list the files in the input directory

# Any results you write to the current directory are saved as output.
voice <- read.csv("voice.csv", header=TRUE, sep=";")
names(voice) <- c("id", "meanfreq", "sd", "median", "Q25", "Q75", "IQR", "skew",
                 "kurt", "sp.ent", "sfm", "mode", "centroid", "meanfun",
                 "minfun", "maxfun", "meandom", "mindom", "maxdom", "dfrange",
                 "modindx", "label")
voice.active<-voice[,1:20]
voice.scaled<-scale(voice.active, scale=TRUE, center=TRUE)
voice.km<-kmeans(voice.scaled, 2, iter.max=10)
table(voice$label,voice.km$cluster)

#The result of table is not that good so we will try to enhance more

voice$label<-factor(voice$label)
summary(voice)

tabplot::tableplot(voice,select=1:21,sortCol=21,nBins=300)


p1 <- ggplot(voice,aes(x=sd,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p2 <- ggplot(voice,aes(x=label,y=sd,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

p3 <- ggplot(voice,aes(x=Q25,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p4 <- ggplot(voice,aes(x=label,y=Q25,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

p5 <- ggplot(voice,aes(x=IQR,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p6 <- ggplot(voice,aes(x=label,y=IQR,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

p7 <- ggplot(voice,aes(x=sp.ent,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p8 <- ggplot(voice,aes(x=label,y=sp.ent,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

p9 <- ggplot(voice,aes(x=sfm,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p10 <- ggplot(voice,aes(x=label,y=sfm,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

p11 <- ggplot(voice,aes(x=meanfun,group=label,fill=label))+
  geom_histogram(position="identity",alpha=.4,bins=40)+
  scale_fill_brewer(palette="Set1")
p12 <- ggplot(voice,aes(x=label,y=meanfun,colour=label))+
  geom_boxplot(size=1)+
  scale_colour_brewer(palette="Pastel1")

plotslist <- list(p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12)
grid.arrange(grobs = plotslist,stat="count" ,ncol=4,nrow=3)

voice$sdcut <- quantcut(voice$sd)
prop.table(xtabs(~sdcut+label,data=voice),1)

voice$Q25cut <- quantcut(voice$Q25)
prop.table(xtabs(~Q25cut+label,data=voice),1)

voice$IQRcut <- quantcut(voice$IQR)
prop.table(xtabs(~IQRcut+label,data=voice),1)

voice$sp.entcut <- quantcut(voice$sp.ent)
prop.table(xtabs(~sp.entcut+label,data=voice),1)

voice$sfmcut <- quantcut(voice$sfm)
prop.table(xtabs(~sfmcut+label,data=voice),1)

voice$meanfuncut <- quantcut(voice$meanfun)
prop.table(xtabs(~meanfuncut+label,data=voice),1)

#so we will use the following cols sd Q25 IQR sp.ent sfm meanfun
voice.active<-voice[,c(2,4,6,9,10,13)]
voice.scaled<-scale(voice.active, scale=TRUE, center=TRUE)
voice.km<-kmeans(voice.scaled, 2, iter.max=10)

fviz_cluster(voice.km, data = voice.scaled, geom = "point", stand = FALSE, ellipse.type = "convex")

table(voice$label,voice.km$cluster)


