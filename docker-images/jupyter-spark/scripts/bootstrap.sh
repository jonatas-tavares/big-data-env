#!/bin/bash

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"

# Time needed to HDFS leaves the Safe Mode
echo "-- Aguardando inicialização do HDFS --"
sleep 60

if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    sleep 2

    # Create shared dir in HDFS to put Spark JARS (acelera a distribuição)
    echo "-- copying Jars --"
    sleep 2
    hdfs dfs -mkdir -p /user/spark/share/lib
    hdfs dfs -put /usr/spark/jars/*.jar /user/spark/share/lib

else

    echo "-- Not first container startup --"
    sleep 2

fi 

echo "-- Starting Notebook --"
sleep 2

# Go to dir matching Volume in Docker-compose to start jupyter
cd /mnt/jupyter

# Start jupyter without autentication 
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

while :; do sleep 2073600; done