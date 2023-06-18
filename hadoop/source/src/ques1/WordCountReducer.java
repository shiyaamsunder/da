package ques1;


import org.apache.hadoop.mapred.*;

import java.io.IOException;
import java.util.Iterator;

import org.apache.hadoop.io.*;

public class WordCountReducer extends MapReduceBase implements Reducer<Text, IntWritable, Text, IntWritable> {
    public void reduce(Text key, 
    				   Iterator<IntWritable> values, 
    				   OutputCollector<Text, IntWritable> output, 
    				   Reporter reporter) throws IOException {
        int sum = 0;

        while (values.hasNext()) {
            sum += values.next().get();
        }

        output.collect(key, new IntWritable(sum));
    }
}
