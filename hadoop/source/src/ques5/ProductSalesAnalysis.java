package ques5;

import java.io.IOException;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Reducer;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

public class ProductSalesAnalysis {

    // Mapper Class
    public static class SalesMapper extends Mapper<Object, Text, Text, IntWritable> {

        private final static IntWritable sales = new IntWritable();
        private final Text product = new Text();

        public void map(Object key, Text value, Context context) throws IOException, InterruptedException {
            String[] fields = value.toString().split(",");
            if (fields.length == 3) {
                String productName = fields[0].trim();
                int price = Integer.parseInt(fields[1].trim());
                int quantity = Integer.parseInt(fields[2].trim());
                int totalSales = price * quantity;

                product.set(productName);
                sales.set(totalSales);

                context.write(product, sales);
            }
        }
    }

    // Reducer Class
    public static class SalesReducer extends Reducer<Text, IntWritable, Text, IntWritable> {

        private final IntWritable totalSales = new IntWritable();

        public void reduce(Text key, Iterable<IntWritable> values, Context context)
                throws IOException, InterruptedException {
            int sum = 0;

            for (IntWritable value : values) {
                sum += value.get();
            }

            totalSales.set(sum);
            context.write(key, totalSales);
        }
    }

    // Main Class
    public static void main(String[] args) throws Exception {
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "ProductSalesAnalysis");

        job.setJarByClass(ProductSalesAnalysis.class);
        job.setMapperClass(SalesMapper.class);
        job.setReducerClass(SalesReducer.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));

        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}
