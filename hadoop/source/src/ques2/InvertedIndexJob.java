package ques2;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;

import java.io.IOException;
import java.util.Iterator;
import java.util.StringTokenizer;

public class InvertedIndexJob {

    public static class InvertedIndexMapper extends MapReduceBase implements Mapper<LongWritable, Text, Text, Text> {
        private final Text word = new Text();
        private final Text docId = new Text();
//        private String fileName = new String();
      

        public void map(LongWritable key, Text value, OutputCollector<Text, Text> output, Reporter reporter) throws IOException {
        	FileSplit fileSplit = (FileSplit) reporter.getInputSplit();
            String filename = fileSplit.getPath().getName();
        	
        	String line = value.toString();
            StringTokenizer tokenizer = new StringTokenizer(line);
            while (tokenizer.hasMoreTokens()) {
                String token = tokenizer.nextToken();
                // Emit (word, document) as key-value pair
                word.set(token);
                docId.set(filename + "@" + key.toString());
                output.collect(this.word, this.docId);
            }
        }
    }

    public static class InvertedIndexReducer extends MapReduceBase implements Reducer<Text, Text, Text, Text> {
        private final Text result = new Text();

        
        public void reduce(
        		Text key, 
        		Iterator<Text> values, 
        		OutputCollector<Text, Text> output, Reporter rep) throws IOException 
        {
            StringBuilder documents = new StringBuilder();
            while(values.hasNext()) {
                documents.append(values.next()).append(",");
            }
            result.set(documents.toString());
            output.collect(key, result);
        }




		
    }

    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        JobConf job = new JobConf(InvertedIndexJob.class);
        job.setJobName("Inverted Index Job");

        job.setJarByClass(InvertedIndexJob.class);
        job.setMapperClass(InvertedIndexMapper.class);
        job.setReducerClass(InvertedIndexReducer.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(Text.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        JobClient.runJob(job);
    }
}
