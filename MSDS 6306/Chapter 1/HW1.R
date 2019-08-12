# Question 1 - Basic Math

# Part a - Function to compute the log of a positive number
log(64)

# Part b -  What is the default base for the log function? 
log(x,base)

# Part c - the log of a negative number
# The real logarithm is undefined for negative real numbers produces a NAN
log(-15)

# Part d - the square-root of a positive number
sqrt(25)

# Question 2 - Random Number Generation

# Part a - Create a vector of 15 standard normal random 
# variables calculate its mean and SD (Standard Deviation)
random_vector <- rnorm(15)
random_vector

mean(random_vector)
 
sd(random_vector)

# Part b - Change the mean to 10 and the SD to 2 to recalculate
# the vector of 15 random normal variables. Calculate its mean
# and SD
random_vector <- rnorm(15, m = 10, sd = 2)
random_vector

mean(random_vector)

sd(random_vector)

# Because they are both random generated and your 
# changing the mean of the 2nd one produced random numbers around 
# that one. 


# Question 3 - Vector Operations

# Part a -- c - Create 2 vectors for heights and weights of 6 individuals

weights <- c(60, 72, 57, 90, 95, 72)
heights <- c(1.80, 1.85, 1.72, 1.90, 1.74, 1.91)


# Part d - Create a scatterplot of weight vs. height
# Interpret the scatterplot

plot(heights, 
     weights, 
     main = "Weight versus Height for 6 Individuals",
     xlab = "Height (m)",
     ylab = "Weight (kg)")

# height and weight are positively correlated, except
# for a shorter individual who weighs the most.

# Part e - Calculate the BMI for each individual
# BMI = weight in kg divided by the square of the height in m

BMI <- weights / (heights ^ 2)
BMI

# Part f - Calculate the mean for weight

mean_weight <- mean(weights)
mean_weight

# Part g - Subtract the mean for each value of weight

weight_difference <- weights - mean_weight
weight_difference

# part h - Sum the result
# Now you know why we square the deviations from the mean to calculate a
# standard deviation!

sum_of_weight_difference <- sum(weight_difference)
sum_of_weight_difference


# Question 4 - Enter your data science profile in R as a data frame
# Data frame consists of two columns - data science categories, ranking
# Categories - Computer Programming, math, statistics, machine learning, domain
# expertise, communication and presentation skills, and data visualization
# Ranking - 1 as worst, 5 as best for best ranking for each category
# Create a bargraph of your data science profile

Data_Science_Categories <- c("Computer Programming", "Math", "Statistics", "Machine Learning", "Domain Expertise", "Communication & Presentation Skills", "Data Visualization")

Ranking <- c(4,4,3,2,1,2,3)

che <- data.frame(Data_Science_Categories, Ranking)

#Setting margin settings
par(mar=c(11,4,4,4))

# make category names fit under the columns with cex.names and las
barplot(che$Ranking, main="Data Science Ranking", names.arg=che$Data_Science_Categories, ylab="Rankings", las=2, cex.names=.6)
