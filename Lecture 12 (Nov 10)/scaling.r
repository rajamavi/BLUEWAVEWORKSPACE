# Effect of standardization and centering

options(digits = 3)

x <- c(1000, 980, 1201, 600, 5000)
y <- c(0, -1, 2, 0.50, 10)
data <- data.frame(x,y)

data

plot(data, main="Raw data")
text(data, pos=2, labels=c("P1", "P2", "P3", "P4", "P5"))

data.centered <- scale(data, scale=F)
plot(data.centered, main="Centered data")
text(data.centered, pos=2, labels=c("P1", "P2", "P3", "P4", "P5"))

data.scaled <- scale(data, center=F)
plot(data.scaled, main="Scaled data")
text(data.scaled, pos=2, labels=c("P1", "P2", "P3", "P4", "P5"))

data.standardized <- scale(data) # (x - mean(x))/sd(x)
plot(data.standardized, main="Standardized (mean = 0, sd = 1)")
text(data.standardized, pos=2, labels=c("P1", "P2", "P3", "P4", "P5"))

# Note that scaling, transforming, etc. does not change the density curve
plot(density(data$x))
plot(density(data.scaled[,1]))
plot(density(data.centered[,1]))
plot(density(data.standardized[,1]))

dist(data, method="euclidean", diag = T, upper=T)
dist(data.centered, method="euclidean", diag = T, upper=T)
dist(data.scaled, method="euclidean", diag = T, upper=T)
dist(data.standardized, method="euclidean", diag = T, upper=T)
