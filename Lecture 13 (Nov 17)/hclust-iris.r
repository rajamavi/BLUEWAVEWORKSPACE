?# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

# Hierarchical Clustering demonstration as a supervised learning technique.
# For graphing, see http://www.sthda.com/english/wiki/beautiful-dendrogram-visualizations-in-r-5-must-known-methods-unsupervised-machine-learning

library(cluster)
library(factoextra)

rm(list=ls())

data(iris)

# Scale the data
d <- scale(iris[,1:4])

hc.complete <- hclust(dist(d), method="complete")
# A colorful plot
fviz_dend(hc.complete, show_labels=T, palette = "jco", 
          main="HCLUST (Complete Linkage)", k=3)
# Default plot --- utilitarian, but serves the purpose.
plot(hc.complete)
# Cut at around Height = 5 to get 3 clusters, or
clusters.3 <- cutree(hc.complete, 3)
table(clusters.3)
table(iris$Species)
# Clearly, one can improve the clustering to get better classification.

hc.single <- hclust(dist(d), method="single")
fviz_dend(hc.single, show_labels=T, palette = "jco", 
          main="HCLUST (Single Linkage)", k=3)
# Not quite sure where to cut to get 3 clusters.
