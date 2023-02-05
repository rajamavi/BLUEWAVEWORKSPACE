# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology
#
# Scaling of variables affects clustering!  So beware!!

library(factoextra)

rm(list=ls())

#       1     2     3     4     5     6     7    8
x <- c(210,  195,  180,  200,  235,  110,   90, 126)  # Weight in lbs
y <- c(5.08, 4.03, 6.00, 5.02, 5.07, 5.03, 4.0, 5.01) # Height in feets 
                                                      # and inches

# Remember from previous lecture: location of points in a 2-d space
# does not change even after scaling.  In a sense, scaling "adjusts"
# the coordinates.  So, with that ...
plot(x, y, main="Raw Data")
text(x,y, pos=2, labels=c("1", "2", "3", "4", "5", "6", "7", "8"))
# Note point labeled 2, it could go with a cluster that includes 1, 3, 4, 5;
# or it could go with a cluster that includes points 6, 7, 8.

df <- data.frame(weight=x, height=y)
df.scaled <- scale(df)

k <- kmeans(df, centers=2) 
k.scaled <- kmeans(df.scaled, centers=2)

# Now let's see what the clusters looks like, scaled and unscaled.
fviz_cluster(k, data=df, main="Unscaled clusters") # Point 2 in right cluster
fviz_cluster(k.scaled, data=df.scaled, main="Scaled clusters") # Point 2 in
# left cluster

# Look at the distance of point 2 from 1, 3, 4, 5 in the unscaled distance
# matrix.  This makes a case that point 2 belongs in that cluster.
dist(data.frame(x=x, y=y), method="euclidean", upper=T)

# Now, look at the distance of point 2 from 6, 7, 8 in the scaled distance
# matrix, clearly, 2 is closer to points 6, 7, and 8.
dist(scale(data.frame(x=x, y=y)), method="euclidean", upper=T)

# And finally, let's see what's contained in the results returned
# by kmeans()
print(k.scaled)

# Examine k.scaled${cluster, size, centers, totss, withinss}
# totss = tot.withinss + betweenss



