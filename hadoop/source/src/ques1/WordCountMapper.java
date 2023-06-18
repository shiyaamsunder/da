package ques1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.mapreduce.filecache.DistributedCache;



public class WordCountMapper extends MapReduceBase implements Mapper<LongWritable, Text, Text, IntWritable> {
    private final static IntWritable one = new IntWritable(1);
    private Text word = new Text();
    private HashSet<String> keywords;

    public void configure(JobConf conf) {
        // Load keywords from the search file
        keywords = new HashSet<>();
        try {
            Path[] searchFiles = DistributedCache.getLocalCacheFiles(conf);
            if (searchFiles != null && searchFiles.length > 0) {
                // Read the search file and add keywords to the HashSet
                // Modify this part according to your search file format
                BufferedReader reader = new BufferedReader(new FileReader(searchFiles[0].toString()));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] words = line.split(" ");
                    for (String keyword : words) {
                        keywords.add(keyword);
                    }
                }
                reader.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void map(LongWritable key, Text value, OutputCollector<Text, IntWritable> output, Reporter reporter) throws IOException {
        String line = value.toString();
        String[] words = line.split(" ");

        for (String word : words) {
            if (keywords.contains(word)) {
                this.word.set(word);
                output.collect(this.word, one);
            }
        }
    }
}
