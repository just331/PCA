# Title     : PCA Visualization
# Objective : CS 5311 HW #2
# Created by: Justin
# Created on: 10/18/2020


x <- c(2.5, 0.5, 2.2, 1.9, 3.1, 2.3, 2, 1, 1.5, 1.1)
y <- c(2.4, 0.7, 2.9, 2.2, 3.0, 2.7, 1.6, 1.1, 1.6, 0.9)

#plot(x, y, pch = 19)

mean(x)
mean(y)

x1 <- x - mean(x)
y1 <- y - mean(y)



summary(x1)
summary(y1)

plot(x1, y1, pch=19)

c1 <- cov(x1,y1)
c2 <- cov(x1, x1)
c3 <- cov(y1,y1)
c4 <- cov(y1, x1)
m <-matrix(c(c2, c1, c4, c3), nrow = 2, ncol = 2, byrow = TRUE, dimnames = list(c("x", "y"), c("x", "y")))
m


evec <- eigen(m)
evec

pc1 <- x1 * evec$vectors[1,1] + y1 * evec$vectors[2,1]
pc1

pc2 <- x1 * evec$vectors[1,2] + y1 * evec$vectors[2,2]
pc2

data.frame(PC1=pc1, PC2=pc2)
plot(pc1, pc2, pch=19)


data <- data.frame(x,y)
data.pca <- prcomp(data)
data.pca

names(data.pca)
data.pca$x
plot(data.pca$x[,1], data.pca$x[,2], pch=19)

eigen(m)
data.pca
