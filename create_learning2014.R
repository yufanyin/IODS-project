# Exercise 2 Data wrangling
# Yufan
# 11.11.2019
# reference to the data source:
# https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt

# Hi reviewer, please see the newest version (2.1 Data wrangling) in chapter2.rmd

# read the data into memory
lrn14 <- read.table("https://www.mv.helsinki.fi/home/kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=JYTOPKYS3-data)

# Look at the dimensions of the data
dim(lrn14)

# Look at the structure of the data
str(lrn14)

# [1] 183  60

# 'data.frame':	183 obs. of  60 variables:
# gender  : Factor w/ 2 levels "F","M"
# other variables (Age, Attitude, Points, Aa, ... , ST01, ...): int
