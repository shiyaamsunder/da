library(e1071)

data("iris")

df_iris <- data.frame(SLength = iris$Sepal.Length, SWidth = iris$Sepal.Width, Species= as.factor(iris$Species))
df_iris <- df_iris[!(df_iris$Species == "virginica"), ]
table(df_iris)
df_iris
plot(df_iris[, -3], col=(3)/2, pch=19)

svm.model <- svm(df_iris$Species ~ . , data=df_iris, type='C-classification', kernel='linear', scale=FALSE)
summary(svm.model)

points(df_iris[svm.model$index, c(1, 2)], col="red", cex=2)



beta = drop(t(svm.model$coefs)%*%svm.model$SV)
beta0 = svm.model$rho
abline(beta0 / beta[2], -beta[1] / beta[2], col="blue", lty=3)
abline((beta0 - 1) / beta[2], -beta[1] / beta[2], lty = 2)
abline((beta0 + 1) / beta[2], -beta[1] / beta[2], lty = 2)
