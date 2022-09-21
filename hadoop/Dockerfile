FROM openjdk:8-jdk-slim

LABEL maintainer="Jônatas Tavares <jontavpess@gmail.com>"

#Setar JAVA
ENV JAVA_HOME=$JAVA_HOME
ENV PATH $PATH:$JAVA_HOME/bin

# Variaveis de ambiente do Hadoop
ENV HADOOP_VERSION 3.3.4
ENV HADOOP_MINOR_VERSION 3.3
ENV HADOOP_HOME /usr/hadoop
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
#Adicionar hdfs ao path
ENV PATH=$PATH:$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin

#COPY ./assets/hadoop-${HADOOP_VERSION}.tar.gz /tmp

# Ajustes e instalação dos componentes do cluster
RUN mkdir -p usr/hadoop /usr/hadoop/dfs/name /usr/hadoop/dfs/data \
    && apt-get update \
    && apt-get install -y wget ssh \
    && wget -P /tmp "http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
    && tar zvxf /tmp/hadoop-${HADOOP_VERSION}.tar.gz -C ${HADOOP_HOME} --strip-components=1 \
    && rm /tmp/hadoop-${HADOOP_VERSION}.tar.gz \
    && rm -rf ${HADOOP_HOME}/hadoop-${HADOOP_VERSION}/share/doc \
    && chown -R root:root ${HADOOP_HOME} \
    #Remove cache do apt-get
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get clean \
    # Keys dos nodes. Necessarias para se comunicarem por SSH
    && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys \
    && chmod 600 ~/.ssh/authorized_keys

#ficar atento a estrutura de pastas
COPY ./config/config /root/.ssh
RUN chmod 600 /root/.ssh/config 

COPY ./config/*.xml ${HADOOP_CONF_DIR}
COPY ./config/workers ${HADOOP_CONF_DIR}
COPY ./scripts/bootstrap.sh /

EXPOSE 8020 8088

CMD [ "/bin/bash", "/bootstrap.sh" ]