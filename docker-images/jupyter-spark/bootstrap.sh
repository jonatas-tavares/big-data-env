#!/bin/bash

echo "-- Preparando espaço no HDFS --"
#Consegui, esse tempo é o suficiente
sleep 60
hdfs dfs -mkdir -p /user/spark/share/lib

echo "-- Copiando Jars --"
sleep 5
hdfs dfs -put /usr/spark/jars/*.jar /user/spark/share/lib

echo "-- Iniciar Notebook --"
sleep 5
cd /mnt/jupyter
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''

while :; do sleep 2073600; done