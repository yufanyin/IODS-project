# Chapter 6: Analysis of longitudinal data
# yufanyin
# 9.12.2019
# Note: '[Step N]' is used for reviewers to check my work queicky.

# reference to the data source:
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# 6.1 Data wrangling


# 6.1.1 Read the data

# Load the data sets
# [Step 1a]
BPRS <- read.table(file = "G:/C-Open Data Science/0-191030/IODS-project-master/BPRS.txt", sep = " ", header = TRUE)
rats <- read.table(file = "G:/C-Open Data Science/0-191030/IODS-project-master/rats.txt", stringsAsFactors = F)

# check the data frame
# [Step 1b]

dim(BPRS)
head(BPRS)
str(BPRS)

# The ¡®BPRS¡¯ data consist of 40 observations in 11 variables.

dim(rats)
head(rats)
str(rats)

# The ¡®rats¡¯ data consist of 16 observations in 13 variables.

# 6.1.2 Convert the categorical variables to factors
# [Step 2]

# Load necessary packages
library(tidyr)
library(dplyr)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)

rats$ID <- factor(rats$ID)
rats$Group <- factor(rats$Group)
str(rats)

# 6.1.3 Convert the data sets to long form
# [Step 3]

# Add a week variable to BPRS
BPRS_l <-  BPRS %>% gather(key = weeks, value = BPRS, -treatment, -subject)
glimpse(BPRS_l)
BPRS_l <- BPRS_l %>% mutate(week = as.integer(substr(weeks,5,5)))
glimpse(BPRS_l)

# Add a Time variable to rats
rats_l <- rats %>% gather(key = WD, value = Weight, -ID, -Group) 
glimpse(rats_l)
rats_l <- rats_l %>% mutate(Time = as.integer(substr(WD,3,4)))
glimpse(rats_l)

# 6.1.4 Compare the new data sets with their wide form versions
# [Step 4]

View(BPRS_l)
str(BPRS_l)

# The long form 'BPRS_l' can be analysed in a better way.
# The former wide form used the week number as a variable. Now all values of the data were transformed to the long form. Hence each BPRS value could be comparable with treatment, subject and week number.
# All shorter columns were put after each other relating to the week number, in the time order.

View(rats_l)
str(rats_l)

# Similarly, the weights and times were in separate variables, after each other in a time series.

# 6.1.5  Save the new data frame

write.table(BPRS_l, 
            file = "G:/C-Open Data Science/0-191030/IODS-project-master/BPRS_l.txt",
            col.names = TRUE, row.names = TRUE)

read.table(file = 
             "G:/C-Open Data Science/0-191030/IODS-project-master/BPRS_l.txt") %>% str()

# The data consist of 360 observations in 5 variables.
# "treatment", "subject", "weeks", "BPRS", "week"

write.table(rats_l, 
            file = "G:/C-Open Data Science/0-191030/IODS-project-master/rats_l.txt",
            col.names = TRUE, row.names = TRUE)

read.table(file = 
             "G:/C-Open Data Science/0-191030/IODS-project-master/rats_l.txt") %>% str()

# The data consist of 155 observations in 8 variables.
# "ID", "Group", "WD", "Weight", "Time"
