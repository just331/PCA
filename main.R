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
