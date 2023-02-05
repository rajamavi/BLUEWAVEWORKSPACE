# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

# Hierarchical Clustering demonstration.
# For graphing, see http://www.sthda.com/english/wiki/beautiful-dendrogram-visualizations-in-r-5-must-known-methods-unsupervised-machine-learning

rm(list=ls())

options(digits=0) # Round up the numbers

setwd("/home/vkg/IIT/CS422/lectures/clustering")
data <- read.csv("distances.csv", sep=",", header=T, comment.char = "#")

dist(data[,2:8], diag = T, upper = T)

c.single <- hclust(dist(data[,2:8]), method="single")
plot(c.single, labels=c("ORD", "LAS", "DFW", "JFK", "ATL", "MSP", "PHL"))

c.complete <- hclust(dist(data[,2:8]), method="complete")
plot(c.complete, labels=c("ORD", "LAS", "DFW", "JFK", "ATL", "MSP", "PHL"))

c.average <- hclust(dist(data[,2:8]), method="average")
plot(c.average, labels=c("ORD", "LAS", "DFW", "JFK", "ATL", "MSP", "PHL"))

