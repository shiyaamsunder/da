package ques6;

import java.io.IOException;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class GlucoseAverage {
  
  public static class GlucoseMapper extends Mapper<Object, Text, Text, FloatWritable> {
    
    private static final Text constantKey = new Text("constant");
    
    public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
		if (value.toString().startsWith("Pregnancies,Glucose,BloodPressure,SkinThickness,Insulin,BMI,DiabetesPedigreeFunction,Age,Outcome")) {
      return;
    }
      // Assuming the glucose level is in the third column (index 2)
      String[] tokens = value.toString().split(",");
      if (tokens.length >= 2) {
        float glucoseLevel = Float.parseFloat(tokens[1]);
        context.write(constantKey, new FloatWritable(glucoseLevel));
      }
    }
  }
  
  public static class GlucoseReducer extends Reducer<Text, FloatWritable, Text, FloatWritable> {
    
    public void reduce(Text key, Iterable<FloatWritable> values, Context context) throws IOException, InterruptedException {
      float sum = 0;
      int count = 0;
      for (FloatWritable value : values) {
        sum += value.get();
        count++;
      }
      
      float average = sum / count;
      context.write(key, new FloatWritable(average));
    }
  }
  
  public static void main(String[] args) throws Exception {
    Configuration conf = new Configuration();
    Job job = Job.getInstance(conf, "Glucose Average");
    job.setJarByClass(GlucoseAverage.class);
    job.setMapperClass(GlucoseMapper.class);
    job.setReducerClass(GlucoseReducer.class);
    job.setOutputKeyClass(Text.class);
    job.setOutputValueClass(FloatWritable.class);
    FileInputFormat.addInputPath(job, new Path(args[0]));
    FileOutputFormat.setOutputPath(job, new Path(args[1]));
    System.exit(job.waitForCompletion(true) ? 0 : 1);
  }
}
