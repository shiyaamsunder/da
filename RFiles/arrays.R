#vectors
my_vec <- c("chennai", "madurai", "coimbatore")
my_vec

#creating a vector in a sequence with increment steps by 2
list <- seq(0, 10, by=2)
list

#repeat vectors
repeat_each <- rep(list, each=3)
repeat_each

#list
thislist <- list("apple", "banana", "cherry")
thislist


#checking whether a item is in the list
thislist <- list("apple", "banana", "cherry")

"apple" %in% thislist

#adding an item to list
append(thislist, "orange")


#matrix
thismatrix <- matrix(c("apple", "banana", "cherry", "orange", "grape", "pineapple", "pear", "melon", "fig"), nrow = 3, ncol = 3)
thismatrix

#accessing items
thismatrix[1, 2]


#accessing more than one row
thismatrix[c(1, 2),]

#accessing more than one column
thismatrix[, c(1, 2)]


#adding new columns
new_matrix <- cbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
new_matrix


#adding new rows
new_matrix <- rbind(thismatrix, c("strawberry", "blueberry", "raspberry"))
new_matrix



#arrays
thislist <- c(1, 2)
thisarray <- array(thislist)
thislist
thisarray
typeof(thislist)

arr = array(0.0, c(2,5,3))
arr


# dataframes
Data_frame = data.frame(
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 35)
)

Data_frame

summary(Data_frame)


#accessing the items
Data_frame$Training

Data_Frame <- data.frame (
  Training = c("Strength", "Stamina", "Other"),
  Pulse = c(100, 150, 120),
  Duration = c(60, 30, 45)
)

# Add a new row
New_row_DF <- rbind(Data_Frame, c("Strength", 110, 110))

# Print the new row
New_row_DF


#factors
# Create a factor
music_genre <- factor(c("Jazz", "Rock", "Classic", "Classic", "Pop", "Jazz", "Rock", "Jazz"))

# Print the factor
music_genre


