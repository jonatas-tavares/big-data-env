import findspark
from pyspark import SparkSession

findspark.init('/usr/spark')
#spark = SparkSession.Builder.
spark = SparkSession.builder.appName("pysparkApp").getOrCreate()
sc = spark.sparkContext