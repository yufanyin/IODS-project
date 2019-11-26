# Chapter 5: Dimensionality reduction techniques
# yufanyin
# 25.11.2019
# reference to the data source:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv

# Note: '[Step N]' is used for reviewers to check my work queicky.

# 5.1 Data wrangling

# 5.1.1 Read the data into memory
# [Step 2]

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


# 5.1.2 Explore the structure and dimensions of the data
# [Step 3a]

head(hd)
dim(hd)
str(hd)
summary(hd)

head(gii)
dim(gii)
str(gii)
summary(gii)

# 5.1.3 Rename the variables with (shorter) descriptive names
# [Step 4]

  
# The data 'hd'consists of 195 observations in 8 variables.

# HDI.Rank: rank1
# Country: ctr1
# Human.Development.Index..HDI.: hd
# Life.Expectancy.at.Birth: lifex
# Expected.Years.of.Education: eyedu
# Mean.Years.of.Education: myedu
# Gross.National.Income..GNI..per.Capita: gni1
# GNI.per.Capita.Rank.Minus.HDI.Rank: d

# The data 'gii'consists of 195 observations in 10 variables.

# GII.Rank: rank2
# Country: ctr2
# Gender.Inequality.Index..GII.: gii
# Maternal.Mortality.Ratio: mmr
# Adolescent.Birth.Rate: abr
# Percent.Representation.in.Parliament: repar
# Population.with.Secondary.Education..Female.: edu2F
# Population.with.Secondary.Education..Male.: edu2M
# Labour.Force.Participation.Rate..Female.: labF
# Labour.Force.Participation.Rate..Male.: labF

head(gii)

library(dplyr)

gii <- rename(gii, rank2 = GII.Rank)
gii <- rename(gii, ctr2 = Country)
gii <- rename(gii, gii = Gender.Inequality.Index..GII.)
gii <- rename(gii, mmr = Maternal.Mortality.Ratio)
gii <- rename(gii, abr = Adolescent.Birth.Rate)
gii <- rename(gii, repar = Percent.Representation.in.Parliament)
gii <- rename(gii, edu2F = Population.with.Secondary.Education..Female.)
gii <- rename(gii, edu2M = Population.with.Secondary.Education..Male.)
gii <- rename(gii, labF = Labour.Force.Participation.Rate..Female.)
gii <- rename(gii, labM = Labour.Force.Participation.Rate..Male.)

head(gii)


# 5.1.4 Mutate the ¡°Gender inequality¡± data and create two new variables
# [Step 5]


gii <- mutate(gii, edu2F_edu2M = edu2F/edu2M)

gii <- mutate(gii, labF_labM = labF/labM)



