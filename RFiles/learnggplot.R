# install.packages("tidyverse")
library(tidyverse)
data()
?iris

ggplot(data=iris, 
       mapping= aes(x = Petal.Width,
                    y = Sepal.Width,
                    color = Species)) + 
  geom_point(size=2, alpha=0.6) +
  geom_smooth(se=FALSE, 
              method = "lm", 
              formula = y~poly(x,2), 
              linewidth = 1.5) +
labs(title = "Species of flowers based on Petal Width and Sepal Width")
