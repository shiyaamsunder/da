package ques3;

import java.io.IOException;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.mapreduce.lib.input.TextInputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;

public class MatrixMultiplication {

    public static class Map extends Mapper<LongWritable, Text, Text, Text> {

        private int m;
        private int p;

        @Override
        protected void setup(Context context) throws IOException, InterruptedException {
            Configuration conf = context.getConfiguration();
            m = conf.getInt("m", 0);
            p = conf.getInt("p", 0);
        }

        public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
            String[] tokens = value.toString().split(",");

            int i = Integer.parseInt(tokens[0]);
            int j = Integer.parseInt(tokens[1]);
            String source = tokens[2];
            int val = Integer.parseInt(tokens[3]);

            if (source.equals("A")) {
                for (int k = 0; k < p; k++) {
                    context.write(new Text(i + "," + k), new Text("A," + j + "," + val));
                }
            } else if (source.equals("B")) {
                for (int k = 0; k < m; k++) {
                    context.write(new Text(k + "," + j), new Text("B," + i + "," + val));
                }
            }
        }
    }

    public static class Reduce extends Reducer<Text, Text, Text, IntWritable> {

        public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
            Configuration conf = context.getConfiguration();
            int n = conf.getInt("n", 0);

            int[] rowA = new int[n];
            int[] colB = new int[n];

            for (Text val : values) {
                String[] tokens = val.toString().split(",");
                String source = tokens[0];
                int i = Integer.parseInt(tokens[1]);
                int value = Integer.parseInt(tokens[2]);

                if (source.equals("A")) {
                    rowA[i] = value;
                } else if (source.equals("B")) {
                    colB[i] = value;
                }
            }

            int sum = 0;
            for (int x = 0; x < n; x++) {
                sum += rowA[x] * colB[x];
            }

            context.write(key, new IntWritable(sum));
        }
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        conf.setInt("m", 3);  // Set the number of rows for Matrix A
        conf.setInt("n", 3);  // Set the number of common dimension
        conf.setInt("p", 3);  // Set the number of columns for Matrix B

        Job job = Job.getInstance(conf, "matrix multiplication");

        job.setJarByClass(MatrixMultiplication.class);
        job.setMapperClass(Map.class);
        job.setReducerClass(Reduce.class);

        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(Text.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        job.setInputFormatClass(TextInputFormat.class);
        job.setOutputFormatClass(TextOutputFormat.class);

        TextInputFormat.addInputPath(job, new Path(args[0]));
        TextOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
