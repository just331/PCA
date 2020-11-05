# CS5311 Assignment #2  

The source code to this assignment can be viewed at:  https://github.com/just331/PCA

The demonstration video can be watched: https://youtu.be/MX0ODf1mhP8

##Q1:   Describe the meaning of the term “eigen faces”. How does it relate to PCA as studied in this class? Explain the steps used to undertake eigen faces based face classification. 
Eigen faces are a set of eigenvectors that are used to assist in the recognition of faces, images in general. The process to getting these eigenfaces involves reducing each image from a 
data set to a vector. We then perform PCA to get a linear subspace for the faces. This space, which now has a very minimal footprint (i.e., low-dimensional space) allows us to compare a vast number of images/faces to look at 
for classification. The process is as follow (From: https://rpubs.com/JanpuHou/469414 ):
1. Prepare data where each row is an image
2. Subtract mean image from the data 
3. Find eigenvectors and values from covariance matrix
4. Select principal components 
5. Project into subspace


## Reports for Assignment 
This program makes uses the R programming language, as well as the Shiny R package to create an interactive web app to perform PCA on
clean data uploaded via a csv file. Any csv file can be used, so long as the data is clean, but for this demonstration I will attach two example datasets to use.
The first one is famous iris dataset that is often used in data science and the second dataset (pizza.csv) is a pizza brand identification set (https://data.world/sdhilip/pizza-datasets). The second objective for this web app is to allow a user to perform eigenface classification on a preset dataset

![ScreenShot](https://github.com/just331/PCA/blob/master/pca1.JPG)

Once the user has uploaded a data file, they will be able to immediately see their table in a table to check to ensure it was uploaded correctly.  
After the user has checked their data they then can move to the second tab "PCA Analysis & Visualization" to both see PCA be calculated on the selected columns 
as well as visually see the rests of said PCA. The user can also change what principal component they want to see against their data, as well the ability to group 
their data based on the results of PCA.

![ScreenShot](https://github.com/just331/PCA/blob/master/pca2.JPG)

## EigenFace Analysis 
Was unable to understand how to do this part