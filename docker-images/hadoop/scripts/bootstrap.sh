#!/bin/bash

service ssh start

if [ "$HOSTNAME" = namenode ]; then
    # The namenode needs to be formatted on his first start or it loses functionality
    # But formatting only the namenode with persistent data in the datanode leads to bugs
    # If you format everything there is no data continuity

    CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
    DIR="/usr/hadoop/dfs/name"

    if [ ! -e $CONTAINER_ALREADY_STARTED ]; then

        touch $CONTAINER_ALREADY_STARTED
        echo "-- First container startup --"
        sleep 2
        
        # Verify if Docker volume persistent data exists 
        if [ -z "$(ls -A $DIR)" ]; then

            echo "-- $DIR is Empty --"
            echo "-- Formating Namenode --"
            sleep 2

            hdfs namenode -format

        else 

            echo "-- $DIR is not Empty --"
            sleep 2

        fi  

    else

        echo "-- Not first container startup --"

    fi
    
    echo "-- Starting Namenode --"
    sleep 2
    hdfs --daemon start namenode
    yarn --daemon start resourcemanager

else

    hdfs --daemon start datanode
    yarn --daemon start nodemanager 

fi

while :; do sleep 2073600; done