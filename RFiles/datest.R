data = data.frame(x=c(1.7, 1.5, 2.8, 5, 1.3, 2.2, 1.3), y=c(368, 340, 665, 954, 331, 556, 376))
library(tidyverse)

model = lm(data$y ~ data$x, data=data)
summary(model)
plot(data)

ggplot(data=data, mapping=aes(x=x, y=y)) + geom_point(size=2, color="blue")
+ geom_smooth(se=FALSE,
              method="lm",
              )

abline(model)
predict(model, newdata=data.frame(x=c(5.8, 5.8, 5.8, 5.8, 5.8, 5.9, 5.8)))
y = coef(model)[2] * 1.7 + coef(model)[1]
y
x=c(c(10,20),c(20,30))