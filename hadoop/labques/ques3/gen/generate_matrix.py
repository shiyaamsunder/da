import numpy as np



import os
# Define the directory path
directory = "../input"

# Create the directory if it doesn't exist
os.makedirs(directory, exist_ok=True)

# Define the file path
file_path = os.path.join(directory, "input.txt")


def generate_input_file(m, n, p, filename):
    matrix_A = np.random.randint(1, 10, size=(m, n))
    matrix_B = np.random.randint(1, 10, size=(n, p))

    with open(filename, 'w') as file:
        # Write Matrix A values
        for i in range(m):
            for j in range(n):
                file.write(f"{i},{j},A,{matrix_A[i][j]}\n")

        # Write Matrix B values
        for i in range(n):
            for j in range(p):
                file.write(f"{i},{j},B,{matrix_B[i][j]}\n")

    print(f"Input file '{filename}' generated.")

# Generate an input file with size 100x100x100 and save it
generate_input_file(100, 100, 100, file_path)

