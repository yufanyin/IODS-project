# Chapter 3: Logistic regression
# Yufan
# 18.11.2019
# reference to the data source:
# https://archive.ics.uci.edu/ml/machine-learning-databases/00320/

# Note: '[Step N]' is used for reviewers to check my work queicky.

# 3.1 Data wrangling

# 3.1.1 Read the data into memory
# [Step 3a]

getwd()
setwd("G:/C-Open Data Science/0-191030/IODS-project-master")
mat <- read.csv(file = "G:/C-Open Data Science/0-191030/IODS-project-master/student-mat.csv", sep = ";", header = TRUE)

getwd()
setwd("G:/C-Open Data Science/0-191030/IODS-project-master")
por <- read.csv(file = "G:/C-Open Data Science/0-191030/IODS-project-master/student-por.csv", sep = ";", header = TRUE)

# 3.1.2 Explore the structure and dimensions of the data
# [Step 3b]

head(mat)
dim(mat)
str(mat)

head(por)
dim(por)
str(por)

# 3.1.3 Join the two data sets
# [Step 4a]

library(dplyr)

# Variables as student identifiers: "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet"

# define the common columns of the data set ("comcol")
comcol <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# check the input
comcol

# Join the two data sets
mat_por <- inner_join(mat, por, by = comcol, suffix = c(".mat", ".por"))


# 3.1.4 Explore the structure and dimensions of the joined data
# [Step 4b]

dim(mat_por)
str(mat_por)
glimpse(mat_por)
colnames(mat_por)

# The data consists of 382 observations in 53 variables.

# 3.1.5 Join the duplicates answers in the joined data
# [Step 5]

# Create a new data frame "alc" using the common columns
alc <- select(mat_por, one_of(comcol))
dim(alc)
head(alc)

# Define the columns "unused" that were not used to join the two data sets
unused <- colnames(mat)[!colnames(mat) %in% comcol]

# Check the columns not used for joining
unused


for(col_name in unused) {
  two_col <- select(mat_por, starts_with(col_name))
  first_col <- select(two_col, 1) # if that first column vector is numeric
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_col))
  } else { # else if it's not numeric...
    alc[col_name] <- first_col
  }
}

# glimpse at the new combined data and check dimensions and first six rows
dim(alc)
head(alc)
glimpse(alc)


# 3.1.6 Create a new column "alc_use" by taking an average of weekday and weekend alcohol consumption
# [Step 6]

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# check the new column
head(alc) 

# Define a new column "high_use": alc_use greater than 2
alc <- mutate(alc, high_use = alc_use > 2)

# 3.1.7 Glimpse at the joined and modified data
# [Step 7a]

dim(alc)
head(alc)
glimpse(alc)

# 3.1.8 Save it as a csv file
# [Step 7b]

write.csv(alc, file = "G:/C-Open Data Science/0-191030/IODS-project-master/alc.csv")

# Check if the file can be read
read.csv(file = "G:/C-Open Data Science/0-191030/IODS-project-master/alc.csv") %>% head()
