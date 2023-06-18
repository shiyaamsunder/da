# Load data
library(readxl)
diabetes <- read.csv("R/diabetes.csv")
View(diabetes)
colnames(diabetes) <- c("Pregnancies", "Glucose", "BloodPressure", "SkinThickness", "Insulin", "BMI", "DiabetesPedigreeFunction", "Age", "Outcome")

# Load required packages
library(caTools)

# Split the data into training and testing sets
set.seed(123)
split <- sample.split(diabetes$Outcome, SplitRatio = 0.7)
train <- subset(diabetes, split==TRUE)
test <- subset(diabetes, split==FALSE)

# Train a linear regression model using age and BMI as independent variables
model <- lm(Outcome ~ Glucose + BMI, data=train)
summary(model)

# Make a prediction for a new data point
new_data <- data.frame(Glucose = 180, BMI = 33.6)
prediction <- predict(model, newdata = new_data)
print(paste("Predicted Outcome:", prediction))

# Plot the relationship between Age and BMI and their effect on Outcome
plot(diabetes$Glucose, diabetes$BMI, col = ifelse(diabetes$Outcome == 1, "red", "black"), 
     xlab = "Glucose", ylab = "BMI")
abline(model, col = "blue", lwd = 2)
legend("topright", legend = c("Outcome=0", "Outcome=1"), col = c("black", "red"), 
       pch = 1, bty = "n")
