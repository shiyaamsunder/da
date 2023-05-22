
library(ggplot2)

path <- "datasets\\diabetes.csv"
path2 <- "datasets\\diabetes_2.csv"


# BMI and blood glucose level


df = read.csv(path)
df2 = read.csv(path2)

bmi1 = df$BMI
bmi2 = df2$bmi

glucose1 = df$Glucose
glucose2 = df2$blood_glucose_level

model1 = lm(df$Outcome~glucose1+bmi1 , data=df)

model2 = lm(bmi2 ~ glucose2 , data=df2)
summary(model1)

cor(df$DiabetesPedigreeFunction + glucose1 + bmi1 + df$Age, df$Outcome)
inpu1 <- data.frame(glucose1=c(120, 121, 125, 180, 190, 200), bmi1=c(33, 45, 22, 34, 25, 40))

intercept = unname(model1$coefficients[1])
glucose = unname(model1$coefficients[2])

summary(model1)
predict(model1, newdata=inpu1)
