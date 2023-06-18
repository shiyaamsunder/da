datapath <- "C:\\Users\\Admin\\Downloads\\data.txt"
headers <- c("housesize", "rooms", "price")


data <- read.csv(datapath, sep=",", header = FALSE)
colnames(data) <- headers
plot(data$housesize, data$price, main="House size vs price", xlab="House Size", ylab="Sales", col="red", pch=19)
typeof(data$housesize)

d = data.frame(x=c(1.7, 1.5, 2.8, 5, 1.3, 2.2, 1.3), y=c(368,340,665,954,331,556,376))
model = lm(d$y~d$x, data=d)
summary(model)
predict
