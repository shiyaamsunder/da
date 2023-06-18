# Instructions

## How to Run

Im following a directory structure like this

```
/user
    -/username
        - /ques1
            - /input
            - /output
        - /ques2
            - /input
            - /output
```

where each question has its own directory with an input dir and an output dir.

if any of the directories have been created before remove it using this command.

```bash
hdfs dfs -rm -r /user/shiyaam/*
```

```bash
cd labques
hdfs dfs -mkdir -p /user/shiyaam/ques1 /user/shiyaam/ques2/ /user/shiyaam/ques3/ /user/shiyaam/ques4/


```

### Question 1

Deleting all the previously generated output and creating new folders.
And executing the job.

Uploading the text of War and Peace as the input and counting the words provided in `ques1/input/search.txt`. Modify that file to see a different output.

```bash
hdfs dfs -rm -r /user/shiyaam/ques1/*
hdfs dfs -mkdir -p /user/shiyaam/ques1/input
hdfs dfs -put ques1/input/ /user/shiyaam/ques1
hadoop jar da.jar ques1.WordCount /user/shiyaam/ques1/input/warandpeace.txt /user/shiyaam/ques1/output/ /user/shiyaam/ques1/input/search.txt

```

Checking the output

```bash
hdfs dfs -cat /user/shiyaam/ques1/output/part-00000
```

### Question 2

Uploading multiple documents from `ques2/input/*`.
Add more documents with different text in that folder to see different output.

```bash
hdfs dfs -rm -r /user/shiyaam/ques2/*
hdfs dfs -mkdir -p /user/shiyaam/ques2/input
hdfs dfs -put ques2/input/ /user/shiyaam/ques2
hadoop jar da.jar ques2.InvertedIndexJob /user/shiyaam/ques2/input/ /user/shiyaam/ques2/output

```

Checking the output

```bash
hdfs dfs -cat /user/shiyaam/ques2/output/part-00000
```

### Question 3

`ques3/input/` has an python file called `generate_matrix.py` which will generate two 3x3 Matrices A and B and write the values to another text file.

- To change the dimensions open `generate_matrix.py`.
- Modify the last line `generate_input_file(m, n, p, "matrix_input.txt")`

  - **m** - No of rows in Matrix A
  - **p** - No of columns in Matrix B

  - **n** - No of columns in Matrix A as well as No of rows in Matrix B.

For example `generate_input_file(100, 100, 100, "matrix_input.txt")` will create matrices A and B with dimensions 100x100 respectively.

- After modifying m, n, p, open the `../source` folder in eclipse and find the `MatrixMultiplication.java` file under `ques3` package.
- In the `main()` function modify the corresponding m, n and p values so that it matches whatever you typed in `generate_matrix.py`.

- Example :

  ```java

  public static void main(String[] args) throws Exception {
      Configuration conf = new Configuration();
      conf.setInt("m", 100);  // Set the number of rows for Matrix A
      conf.setInt("n", 100);  // Set the number of common dimension
      conf.setInt("p", 100);  // Set the number of columns for Matrix B

      ....
  }
  ```

After all these steps [export the project as jar file.](#recompile-the-jar-file).

```bash
hdfs dfs -rm -r /user/shiyaam/ques3/*
hdfs dfs -mkdir -p /user/shiyaam/ques3/input
hdfs dfs -put ques3/input/ /user/shiyaam/ques3
hadoop jar da.jar ques3.InvertedIndexJob /user/shiyaam/ques3/input/ /user/shiyaam/ques3/output/

```

Checking the output

```bash
hdfs dfs -cat /user/shiyaam/ques3/output/part-r-00000
```

### Recompile the JAR file.

- Open the source folder in Eclipse
- Click File > Export > JAR
- Export the entire project as labques/da.jar
- Then run the hadoop jar command.
