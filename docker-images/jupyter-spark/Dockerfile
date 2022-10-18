FROM jontavpess/hadoop-base

LABEL maintainer="Jônatas Tavares <jontavpess@gmail.com>"

# HADOOP environment variables
ENV HADOOP_VERSION 3.3.4
ENV HADOOP_MAJOR_VERSION 3
ENV HADOOP_HOME /usr/hadoop
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop

# JAVA environment variables
ENV JAVA_HOME $JAVA_HOME
ENV PATH $PATH:$JAVA_HOME:$JAVA_HOME/bin

# SCALA environment variables
ENV SCALA_MINOR_VERSION 2.13

# SPARK environment variables
ENV SPARK_VERSION 3.3.0
ENV SPARK_HOME /usr/spark

# Use if debugging
# COPY ./assets/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MAJOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz /tmp

RUN apt-get update \
    && apt-get install -y \
    python3-pip python3-dev jupyter \
    # Spark
    && wget -P /tmp "http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MAJOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz" \
    && mkdir ${SPARK_HOME} \
    && tar zvxf /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MAJOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz -C ${SPARK_HOME} --strip-components=1 \
    && chown -R root:root ${SPARK_HOME} \
    # Cleaning
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean \
    && rm -rf /bootstrap.sh \
    # Assuring that jupyter kernel folder exists to copy custom kernel
    && mkdir -p /usr/share/jupyter/kernels/


# PySpark configurarion
ENV PYSPARK_PYTHON='python3'
ENV PYSPARK_DRIVER_PYTHON='jupyter'
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# Path setting
ENV PYTHONPATH $SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.5-src.zip:/usr/bin/python3:$PYTHONPATH
ENV PATH $PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin:$SPARK_HOME/bin:$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH:$SCALA_HOME/bin

# Istalling Python libraries
COPY ./config/requirements.txt /tmp
RUN pip install -r /tmp/requirements.txt

# Copying configuration files
COPY config/spark-defaults.conf ${SPARK_HOME}/conf/
COPY config/slaves ${SPARK_HOME}/conf/
COPY config/PySpark /usr/share/jupyter/kernels/PySpark
COPY ./scripts/bootstrap.sh /

EXPOSE 4040 8888

CMD ["bin/bash", "/bootstrap.sh"]
