FROM openjdk:8-jdk-slim

LABEL maintainer="Jônatas Tavares <jontavpess@gmail.com>"

# Hadoop environment variables
ENV HADOOP_VERSION 3.3.4
ENV HADOOP_MINOR_VERSION 3.3
ENV HADOOP_HOME /usr/hadoop
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop

# Use if debugging
#COPY ./assets/hadoop-${HADOOP_VERSION}.tar.gz /tmp

RUN apt-get clean

# Tuning and installing hadoop components
RUN mkdir -p usr/hadoop /usr/hadoop/dfs/name /usr/hadoop/dfs/data \
    && apt-get update \
    && apt-get install -y wget ssh \
    && wget -P /tmp "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
    && tar zvxf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C ${HADOOP_HOME} --strip-components=1 \
    && rm /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && rm -rf ${HADOOP_HOME}/hadoop-${HADOOP_VERSION}/share/doc \
    && chown -R root:root ${HADOOP_HOME} \
    # Remove apt-get cache and temporary files
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean \
    # Node keys, required to communicate over SSH
    && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/authorized_keys

# File to turn off strict checking of ssh keys
COPY ./config/config /root/.ssh
# Modifing permissions of config file
RUN chmod 600 /root/.ssh/config

# Copying configuration files
COPY ./config/*.xml ${HADOOP_CONF_DIR}
COPY ./config/workers ${HADOOP_CONF_DIR}
COPY ./scripts/bootstrap.sh /

# Set JAVA environment
ENV JAVA_HOME=$JAVA_HOME
ENV PATH $PATH:$JAVA_HOME/bin

# Add Hadoop to path
ENV PATH=$PATH:$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin

EXPOSE 8020 8088

CMD [ "/bin/bash", "/bootstrap.sh" ]