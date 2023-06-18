X = c(1, 2,2, 3, 10, 3, 4,1, 5)
Y = c(12, 18, 22, 28, 35)

# model = lm(Y~X, data=data.frame(X, Y))
# summary(model)$fstatistic
# 
# predict.lm(model, data.frame(X=c(7, 9)))

barplot(Y, xlab="X-axis", ylab="Y-axis")
v <- c(19, 23, 11, 5, 16, 21, 32,
       14, 19, 27, 39)
hist(v, breaks="fd")

input <- mtcars[, c('mpg', 'cyl')]
print(head(input))

boxplot(mpg ~ cyl, horizontal = TRUE, data = mtcars,
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon",
        main = "Mileage Data")


# Create the data for the chart.
v <- c(17, 25, 38, 13, 41)

# Plot the bar chart.
plot(v, type = "o")