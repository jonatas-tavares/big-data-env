# BIGDATA STUDY ENVIRONMENT WITH DOCKER

The objective of this repository is to configure a cluster containing the respective frameworks, until then being Hadoop (HDFS) and Spark. It can be used as a reference for configuration of the frameworks, for the creation of your own clusters, or as a tool for data analysis or data science with bigdata.

This repository contains the all the required configuration files, dockerfiles to build the images and the docker-compose file to setup a Bigdata study cluster with HDFS and SPARK, runing on docker. This work was inspired by the works of [Fabio Jardim](https://github.com/fabiogjardim/bigdata_docker) and [Gabriel B.](https://github.com/gbieul/spyrk-cluster/), sharing many similarities of both. The main goal here being to expose the process of configuration and creation of such clusters, thus sharing the knowledge in this area and of the frameworks used, enabling the readers, whether for the creation of their own study cluster or even for clusters in production. You can read in detail at [My post in Medium](https://medium.com/@jontavpess).


## SOFTWARE REQUIRED
For the creation and use of the environment we will use ``git`` and ``Docker``.

## SETUP
In a terminal/DOS, inside the directory of choice, clone the project on github
````
    git clone https://github.com/jonatas-tavares/big-data-env.git
````


## STARTING THE ENVIRONMENT
To setup the cluster for the first time, in Windows open PowerShell, from Linux a terminal.

In the big-data-env directory, run docker-compose:
````
    docker-compose up -d
````

To stop the cluster:
````
    docker-compose stop
````

To start the cluster after being stoped:
````
    docker-compose start
````


## Access WebUI of Frameworks
- HDFS http://localhost:9870

- ResourceManager http://localhost:8088

- Jupyter-Spark http://localhost:8888

- Spark http://localhost:4040


## Access by shell
HDFS
````
    docker exec -it datanode bash
````
SPARK
````
    docker exec -it jupyter-spark bash
````
