# Chapter 3: Logistic regression
# Yufan
# 11.11.2019
# reference to the data source:
# https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# read the data into memory
getwd()
setwd("G:/C-Open Data Science/0-191030/IODS-project-master")
mat <- read.csv(file = "G:/C-Open Data Science/0-191030/IODS-project-master/student-mat.csv", sep = ";", header = TRUE)

getwd()
setwd("G:/C-Open Data Science/0-191030/IODS-project-master")
por <- read.csv(file = "G:/C-Open Data Science/0-191030/IODS-project-master/student-por.csv", sep = ";", header = TRUE)

# Explore the structure and dimensions of the data

head(mat)
dim(mat)
str(mat)

head(por)
dim(por)
str(por)

