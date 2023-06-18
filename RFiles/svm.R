# Required Libraries
library(e1071)
library(dplyr)
library(tidyverse)


# Loading the inbuilt iris dataset
data("iris")

# PREPROCESSING
#================================================================
# 
# Using the select function to pick only the columns i want,
# Then using the filter function picking the rows that have either setosa
# or versicolor in the Species column
df_iris <- filter(select(iris, Sepal.Width, Petal.Width, Species))

#=================================================================
# DATASET SPLITTING
# Splitting the dataset into the Training set and Test set
library(caTools)

set.seed(123)
#uniform splitting 
split = sample.split(df_iris$Species, SplitRatio = 0.8)

training_set = subset(df_iris, split == TRUE)
test_set = subset(df_iris, split == FALSE)

training_set
test_set

#======================================================================
#SUMMARY OF THE DATASET
#Summarizing the dataset by grouping the data by Species 
# mean(na.rm) = a logical value indicating whether NA values should be 
# stripped before the computation proceeds.
df_iris_summary <- df_iris %>% 
                   group_by(Species) %>%
                   summarize(mean_sw = mean(Sepal.Width, na.rm = TRUE), 
                            mean_pw = mean(Petal.Width, na.rm = TRUE))
df_iris_summary

#=======================================================================
# PLOT
base_plot <- ggplot(data=training_set, mapping=aes(x=Sepal.Width,
                                 y=Petal.Width,
                                 shape = Species)) +
  geom_point(size=2, alpha=0.6)

base_plot


#=========================================================================
# SVM model
svm.model <- svm(training_set$Species ~ . , 
                 data=training_set, 
                 type='C-classification', 
                 kernel='linear', 
                 scale=FALSE)
summary(svm.model)

#=========================================================================
# SVM PLOT
# beta = drop(t(svm.model$coefs)%*%svm.model$SV)
# beta0 = svm.model$rho
# 
# base_plot +
#   geom_point(data=(training_set[svm.model$index, c(1, 2)]),
#              aes(x=Sepal.Width,
#                  y=Petal.Width),
#              colour='orange',
#              fill='white',
#              shape=1,
#              size=3, stroke=1) +
#   geom_smooth(method='lm', se=FALSE, size=1) +
#   geom_abline(intercept= beta0 / beta[2], slope=-beta[1] / beta[2], color='green')+
#   geom_abline(intercept= (beta0 - 1) / beta[2], slope=-beta[1] / beta[2], lty=2, color='blue')+
#   geom_abline(intercept = (beta0 + 1) / beta[2], slope=-beta[1] / beta[2], lty = 2, color='red')

#==============================================================================   
# Plotting the test data

# PLOT
test_data_plot <- ggplot(data=test_set, mapping=aes(x=Sepal.Width,
                                                   y=Petal.Width,
                                                   color = Species)) +
  
  geom_point(size=2, alpha=0.8)

test_data_plot




  #=====================================================================================