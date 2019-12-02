# Chapter 5: Dimensionality reduction techniques
# yufanyin
# Note: '[Step N]' is used for reviewers to check my work queicky.

# 5.1 Data wrangling

# Part 1 (for Exercise 4; the work for this week is named Part 2)
# 25.11.2019
# reference to the data source:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv

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
# Life.Expectancy.at.Birth: exp_life
# Expected.Years.of.Education: exp_edu
# Mean.Years.of.Education: year_edu
# Gross.National.Income..GNI..per.Capita: gni1
# GNI.per.Capita.Rank.Minus.HDI.Rank: d

library(dplyr)

head(hd)

hd <- rename(hd,rank1 = HDI.Rank)
hd <- rename(hd,hd = Human.Development.Index..HDI.)
hd <- rename(hd,exp_life = Life.Expectancy.at.Birth)
hd <- rename(hd,exp_edu = Expected.Years.of.Education)
hd <- rename(hd,year_edu = Mean.Years.of.Education)
hd <- rename(hd,gni = Gross.National.Income..GNI..per.Capita)
hd <- rename(hd,gni_hdi = GNI.per.Capita.Rank.Minus.HDI.Rank)

head(hd)

# The data 'gii'consists of 195 observations in 10 variables.

library(dplyr)

head(gii)

gii <- rename(gii, rank2 = GII.Rank)
gii <- rename(gii, gii = Gender.Inequality.Index..GII.)
gii <- rename(gii, mat_mor = Maternal.Mortality.Ratio)
gii <- rename(gii, ado_birth = Adolescent.Birth.Rate)
gii <- rename(gii, F_parli = Percent.Representation.in.Parliament)
gii <- rename(gii, edu2F = Population.with.Secondary.Education..Female.)
gii <- rename(gii, edu2M = Population.with.Secondary.Education..Male.)
gii <- rename(gii, labF = Labour.Force.Participation.Rate..Female.)
gii <- rename(gii, labM = Labour.Force.Participation.Rate..Male.)

head(gii)

# 5.1.4 Mutate the ¡°Gender inequality¡± data and create two new variables
# [Step 5]


gii <- mutate(gii, edu2F_edu2M = edu2F/edu2M)

gii <- mutate(gii, labF_labM = labF/labM)

head(gii)

# 5.1.5 Join the two datasets together

# [Step 6]

join = c("Country")

human <- inner_join(hd, gii, by = join, suffix = c(".hd", ".gii")) 

str(human)

write.table(human, file = "G:/C-Open Data Science/0-191030/IODS-project-master/human.txt")



------------------------------------------------------------------------------

  
# Part 2 (for Exercise 5
# 2.11.2019
# reference to the data source:
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt
  
# 5.2.1 Read the data
# [Step 0]

human <- read.table(file = "G:/C-Open Data Science/0-191030/IODS-project-master/human.txt")

# check the data frame

dim(human)
head(human)
str(human)
summary(human)

# The data is the conbination of two data sets, Human Development Index (HDI) and Gender Inequality Index.

# The data consist of 195 observations in 19 variables.

# 5.2.2 Mutate the data
# [Step 1]

# Transform the Gross National Income (GNI) variable to numeric

library(stringr)
str(human$gni)
human$gni
human$GNI <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric()

head(human)
human$GNI

# 5.2.3 Exclude unneeded variables
# [Step 2]

# Keep the following variables
# "Country": country name
# "edu2F_edu2M": ratio of second education of female/male
# "labF_labM": ratio of labour forced female/male
# "exp_edu": expected years of education
# "exp_life": life expectancy at birth
# "GNI": Gross National Income per capita
# "mat_mor": maternal mortality ratio
# "ado_birth": adolescent birth rate
# "F_parli": percetange of female representatives in parliament

# Define the columns to keep
human_select <-c("Country", "edu2F_edu2M", "labF_labM", "exp_edu", "exp_life", "GNI", "mat_mor", "ado_birth", "F_parli")
human_select

# Select the column to keep
human_ana <- select(human, one_of(human_select))

# 5.2.4 Remove all rows with missing values
# [Step 3]

# Check the completeness indicator of the data
complete.cases(human_ana)
# if "NA" was in the data set, the completeness indicator will set to "FALSE"

# Set a data frame with the completeness indicator as the last column
data.frame(human_ana[-1], comp = complete.cases(human_ana))

# Filter out all rows with NA values
human_ana <- filter(human_ana, complete.cases(human_ana))

# Check the data set: no "NA"
human_ana

# 5.2.5 Remove the observations which relate to regions
# [Step 4]

# Check the last 10 observations
tail(human_ana, 10) 
# Rows from 156 to 162 were regions

# Keep the rows from 1 to 155
human_ana <- human_ana[1:155, ]

# Check the last 10 rows
tail(human_ana, 10)

# 5.2.6 Define the row names of the data by the country names and remove the country name column
# [Step 5]

# Add countries as row names
rownames(human_ana) <- human_ana$country

head(human_ana)

# Remove the country column
human_ana <- human_ana[-1]

head(human_ana)
str(human_ana)

# Save the new data frame
write.table(human_ana, 
            file = "G:/C-Open Data Science/0-191030/IODS-project-master/human_ana.txt",
            col.names = TRUE, row.names = TRUE)

read.table(file = 
             "G:/C-Open Data Science/0-191030/IODS-project-master/human_ana.txt") %>% str()

# The data consist of 155 observations in 8 variables.
