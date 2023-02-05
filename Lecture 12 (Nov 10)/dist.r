# CS422 Data Mining
# Vijay K. Gurbani, Ph.D.
# Illinois Institute of Technology

options(digits=3)

# Distance functions

x <- c(0,2,3,5)
y <- c(2,0,1,1)
df <- data.frame(x,y)

# Plot it.
plot(df, bg="lightgreen", pch=21, xlim=c(0,6), ylim=c(0,3))
# See http://www.endmemo.com/program/R/pchsymbols.php for PCH symbols.
text(x,y, pos=4, labels=c("P1","P2","P3","P4"))

d <- dist(df, method="euclidean", upper=T, diag=T) # L2
d

d <- dist(df, method="manhattan", upper=T, diag=T) # L1
d

d <- dist(df, method="maximum", upper=T, diag=T) # L_max
d

