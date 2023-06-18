
# 
library(ggplot2)

data("iris")
b<-ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color=Sepal.Length)) +
  geom_point() +
  stat_smooth(method = "lm", col = "red")


x1 = iris$Petal.Length
x2 = iris$Petal.Width
y = iris$Sepal.Length

data <- data.frame(x1, x2, y)

fit2 <- lm(y~x1+x2, data)
                                                                                 
summary(fit2)
library(car)
avPlots(fit2)

preds<-predict(fit2, newdata=data.frame(x1=4.1, x2=2.8))
predictions<- predict(fit2)
plotdata<- data.frame(Observed=predictions, Actual=y)

# ggplot(plotdata, aes(x=Observed, y=Actual)) +geom_point() +stat_smooth(method="lm", col="green")
