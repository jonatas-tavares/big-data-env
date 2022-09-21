FROM jontavpess/hadoop-base

# Variáveis de ambiente HADOOP
ENV HADOOP_VERSION 3.3.4
ENV HADOOP_MINOR_VERSION 3
ENV HADOOP_HOME /usr/hadoop
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop

# Variáveis de ambiente JAVA
ENV JAVA_HOME=$JAVA_HOME
ENV PATH $PATH:$JAVA_HOME:$JAVA_HOME/bin

# Variáveis de ambiente SCALA
# ENV SCALA_VERSION 2.13.0
ENV SCALA_MINOR_VERSION 2.13
# ENV SCALA_HOME=/usr/scala

# Variáveis de ambiente SPARK
ENV SPARK_VERSION 3.3.0
ENV SPARK_HOME /usr/spark
ENV PATH=$SPARK_HOME/bin:$PATH
#ADICIONADO
#ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native:$LD_LIBRARY_PATH

ENV PYSPARK_DRIVER_PYTHON='jupyter'
ENV PYSPARK_DRIVER_PYTHON_OPTS='notebook'

COPY ./assets/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MINOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz /tmp
#COPY ./assets/scala-${SCALA_VERSION}.tgz /tmp

RUN apt-get update \
    && apt-get install -y \
    python3 python3-pip python3-dev jupyter \
    # Spark
    # && wget -P /tmp "http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MINOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz"
    && mkdir ${SPARK_HOME} \
    && tar zvxf /tmp/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MINOR_VERSION}-scala${SCALA_MINOR_VERSION}.tgz -C ${SPARK_HOME} --strip-components=1 \
    && chown -R root:root ${SPARK_HOME} \
    # Scala
    # && wget -P /tmp "https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" \
    # && mkdir ${SCALA_HOME} \
    # && tar -zvxf /tmp/scala-${SCALA_VERSION}.tgz -C ${SCALA_HOME} --strip-components=1 \
    #Limpeza
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean \
    && rm -rf /bootstrap.sh

COPY config/spark-defaults.conf ${SPARK_HOME}/conf/
COPY config/slaves ${SPARK_HOME}/conf/
COPY bootstrap.sh /

EXPOSE 4040 9000 8888

CMD ["bin/bash", "bootstrap.sh"]
