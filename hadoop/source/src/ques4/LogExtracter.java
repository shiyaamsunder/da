package ques4;


import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;


public class LogExtracter {

	public static class LogMapper extends Mapper<LongWritable, Text, Text, IntWritable>{
		
		public final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
		
		public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
			
			String[] tokens = value.toString().split(",");
			
			String eventType = tokens[1];
			String timestampString = tokens[0];
			
			try {
			Date timestamp = dateFormat.parse(timestampString);
			Date currentTimestamp = new Date();
			
			int duration = (int) (currentTimestamp.getTime() - timestamp.getTime() /1000);
			
			context.write(new Text(eventType), new IntWritable(duration));
			}
			catch(ParseException e) {
				System.out.println(e.getMessage());
			}
		}
	}
	
	
	public static class LogReducer extends Reducer<Text, IntWritable, Text, DoubleWritable>{
		public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException{
			int sum = 0;
			int count = 0;
			
			for(IntWritable value: values) {
				sum+= value.get();
				count++;
			}
			double avgDuration = (double) sum /count;
			context.write(key, new DoubleWritable(avgDuration));
		}
	}
	
	
	public static void main(String[] args) throws Exception {
		Configuration conf = new Configuration();
		
		Job job = Job.getInstance(conf, "Log Analyzer");
		
		job.setJarByClass(LogExtracter.class);
		job.setMapperClass(LogMapper.class);
		job.setReducerClass(LogReducer.class);
		
		job.setMapOutputKeyClass(Text.class);
		job.setMapOutputValueClass(IntWritable.class);
		
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(DoubleWritable.class);
		
		job.setInputFormatClass(TextInputFormat.class);
		job.setOutputFormatClass(TextOutputFormat.class);
		
		TextInputFormat.addInputPath(job, new Path(args[0]));
		TextOutputFormat.setOutputPath(job, new Path(args[1]));
		
		System.exit(job.waitForCompletion(true) ? 0: 1);
	}
	
	
}
