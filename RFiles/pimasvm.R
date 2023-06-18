# Required Libraries
library(e1071) # SVM
library(tidyverse) # ggplot2 
library(dplyr) # Data pre processing
library(caTools) # data splitting
library(caret)
# 
# data <- read.csv("datasets/diabetes.csv")
# 
# 
# data$Outcome <- as.factor(data$Outcome)
# 
# pima_df <- select(data, BMI, Glucose, Outcome)
# pima_df <- filter_if(pima_df, is.numeric, all_vars((.) != 0))
# levels(pima_df$Outcome) <- c("No", "Yes")
# 
# plot(pima_df)
# str(pima_df)
# 
# 
# 
# pima_df
# # Normalize data
# process <- preProcess(pima_df, method='range')
# norm_data <- predict(process, pima_df)
# levels(traindata$Outcome) <- c("Class0", "Class1")
# summary(norm_data)
# plot(norm_data)
# 
# split = sample.split(norm_data$Outcome, SplitRatio = 0.8)
# pima_train_set = subset(norm_data, split==TRUE)
# pima_test_set = subset(norm_data, split==FALSE)
# summary(pima_test_set)
# 
# # ploting
# 
# pima_base_plot <- ggplot(pima_train_set, mapping=aes(y=BMI, 
#                                                 x=Glucose, 
#                                                 color=Outcome)) +
#                   
#                   geom_point(size=2)
# pima_base_plot
# 
# 
# 
# #=========================================================================
# # SVM model
# psvm.model <- svm(pima_train_set$Outcome ~ . , 
#                  data=pima_train_set,
#                  
#                  kernel='linear')
# summary(psvm.model)
# 
# 
# pima_base_plot +
#   geom_point(data=(pima_train_set[psvm.model$index, c(1, 2)]),
#              aes(x=Glucose,
#                  y=BMI),
#              colour='orange',
#              fill='white',
#              shape=1,
#              size=3, stroke=1)
# 
# beta = drop(t(psvm.model$coefs)%*%psvm.model$SV)
# beta0 = psvm.model$rho
# 
# pima_base_plot +
#     geom_point(data=(pima_train_set[svm.model$index, c(1, 2)]),
#                aes(x=Glucose,
#                    y=BMI),
#                colour='orange',
#                fill='white',
#                shape=1,
#                size=3, stroke=1) +
#     geom_abline(intercept= beta0 / beta[2], slope=-beta[1] / beta[2], color='green')+
#     geom_abline(intercept= (beta0 - 1) / beta[2], slope=-beta[1] / beta[2], lty=2, color='blue')+
#     geom_abline(intercept = (beta0 + 1) / beta[2], slope=-beta[1] / beta[2], lty = 2, color='red')
# 
# #================================================================
# 
# pimap<-predict(psvm.model,pima_test_set)
# 
# pimap
# pimatable = table(pred=pimap, actual=pima_test_set$Outcome)
# pimatable


diab <- read.csv("datasets/diabetes.csv")

X <- select(data, BMI, Glucose)  # Excluding the last column (Outcome)
Y <- as.factor(diab$Outcome)

set.seed(123)  # Set a seed for reproducibility
split <- sample.split(Y, SplitRatio = 0.7)  # Split the data into 70% training and 30% testing
X_train <- X[split, ]
Y_train <- Y[split]
X_test <- X[!split, ]
Y_test <- Y[!split]



svm_model <- svm(Y_train ~ ., data = X_train, kernel = "linear")
summary(svm_model)
predictions <- predict(svm_model, X_test)

confusion_matrix <- confusionMatrix(predictions, as.factor(Y_test))
accuracy <- confusion_matrix$overall["Accuracy"]


library(ggpubr)
support_vectors <- svm_model$SV
scatter_plot <- ggplot(data = X_train, aes(x = BMI, y = Glucose, color = Y_train)) +
  geom_point() +
  scale_color_manual(values = c("blue", "red"))
scatter_plot

# SVM PLOT
beta = drop(t(svm_model$coefs)%*%svm_model$SV)
beta0 = svm_model$rho

scatter_plot +
  geom_point(data = support_vectors, aes(x = X_train[, 1], y = X_train[, 2]), shape = 4, size = 3, color = "black") +
  geom_text(data = support_vectors, aes(x = X_train[, 1], y = X_train[, 2], label = rownames(support_vectors)), vjust = -1)

