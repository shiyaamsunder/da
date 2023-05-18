path <- "C:\\Users\\Admin\\Downloads\\diabetes.csv"

data = read.csv(path, header = TRUE)

data$Glucose


# = lm(data$Glucose~data$Outcome)
# ('y =', coef(model)[[2]], '* x', '+', coef(model)[[1]])

smp_size <- floor(0.75 * nrow(data))
set.seed(123)
split <- sample.split(data$Outcome, SplitRatio=0.7)
train <- subset(diabetes, split==TRUE)
test <- subset(diabetes, split==FALSE)


model = lm(data$Outcome~data$Glucose+data$BMI, data=train)
P = predict(model, test)
model
P

actuals_preds = data.frame(cbind (Actual_Value = test $ Outcome, Predicted_Value = P))
actuals_preds

