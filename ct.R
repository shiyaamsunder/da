library(moments)
library(ggplot2)


path <- "C:\\Users\\Admin\\Documents\\2022178022\\datasets\\ds_salaries.csv"

dataset <- read.csv(path)




x <- c(dataset$salary_in_usd, dataset$remote_ratio)
y=dnorm(x)
lines(density(y))
hist(x,  xlim=c(min(x),max(x)), probability=T, nclass=max(x)-min(x)+1, 
breaks = 10, col="blue")

lines(density(x, bw=1), col="green")

qqnorm(x)
qqline(x)

skew <- skewness(x)

skews

data <- data.frame(n, skews)

ggplot(data, aes(n, skews)) +
  geom_line(color = "blue") +
  xlab("Sample size") +
  ylab("Skewness") +
  ggtitle("Skewness by sample size")


abline(v = mean(x), col ="red", lwd = 2)
abline(v = median(x), col="green", lwd=2)
lines(density(x ,bw=1), col='red', lwd=3)

text(mean(x), max(hist(x)$counts), paste0("Skewness = ", round(skew, 2)), pos = 3, col = "red")

dataset$experience_level <- factor(dataset$experience_level)
dataset$experience_level
#hist
unique(dataset$experience_level)
#pie(x, labels = c("SE", "MI", "EN"))
pie(x, labels = unique(dataset$experience_level), col = "white",
    main = "Articles on GeeksforGeeks", radius = -1,
    col.main = "darkgreen")

mn <- mean(x)
md <- median(x)
mde <- (3* md - 2* mn)
deviation <- sd(x)
variance <- var(x)

#kurtosis = (1/n) * sum((x - mean(x))^4) / var(x)^2
kurtosis <- sum((x - mean(x))^4)/length(x) / variance^2

cat("Mean: ", mn, "\n")
cat("Median: ", md, "\n")
cat("Mode: ", mde, "\n")
cat("Standard Deviation: ", deviation, "\n")
cat("Variance: ", variance, "\n")
cat("Kurtosis: ", kurtosis, "\n")
