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

model1 = lm(bmi1 ~ glucose1 ~ , data=df)
model2 = lm(bmi2 ~ glucose2 ~ , data=df2)

inpu1 = data.frame(BMI = c(33, 24), Glucose= c(120, 111))
predict(model1, inpu1)
x=data.frame(x=bmi1)
ggplot(x, aes(x) + geom_line(color="green"))
