datapath <- "C:\\Users\\Admin\\Downloads\\data.txt"
headers <- c("housesize", "rooms", "price")


data <- read.csv(datapath, sep=",", header = FALSE)
colnames(data) <- headers
plot(data$housesize, data$price, main="House size vs price", xlab="House Size", ylab="Sales", col="red", pch=19)
typeof(data$housesize)

model = lm(data$housesize~data$price)
print(model)
