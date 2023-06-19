# Read the words to count from a text file
words_count <- scan("../hadoop/labques/ques1/input/search.txt", what = "character", sep = "\n")

# Read the input text file
input_text <- readLines("../hadoop/labques/ques1/input/warandpeace.txt")

# Define the Map function
map_function <- function(chunk) {
  # Split the chunk into words
  words <- unlist(strsplit(chunk, "\\W+"))
  
  # Count the occurrences of words from words_count
  counts <- table(words)
  matching_counts <- counts[names(counts) %in% words_count]
  
  # Return the matching counts as a list
  as.list(matching_counts)
}

# Split the input text into chunks for parallel processing
num_chunks <- 4  # Adjust the number of chunks as needed
text_chunks <- split(input_text, ceiling(seq_along(input_text) / num_chunks))

# Perform parallel processing using MapReduce-like operations
result <- parallel::mclapply(text_chunks, map_function, mc.cores = num_chunks)

# Combine the results from each chunk
final_counts <- Reduce(function(x, y) merge(x, y, by = "Var1", all = TRUE), result)

# Fill missing values with 0
final_counts[is.na(final_counts)] <- 0

# Rename the columns
colnames(final_counts) <- c("Word", "Count")

# Print the final counts
print(final_counts)
