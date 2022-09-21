#!/bin/bash

service ssh start

if [ "$HOSTNAME" = namenode ]; then
    #Se não for formatado perde a funcionalidade
    #Se formartar só o namenode buga o data node
    #Se formartar tudo não tem continuidade dos dados

    CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
    DIR="/usr/hadoop/dfs/name"

    if [ ! -e $CONTAINER_ALREADY_STARTED ]; then

        touch $CONTAINER_ALREADY_STARTED
        echo "-- First container startup --"
        sleep 5
        # YOUR_JUST_ONCE_LOGIC_HERE

        if [ -z "$(ls -A $DIR)" ]; then
            echo "-- $DIR is Empty --"
            sleep 5

            hdfs namenode -format
            hdfs --daemon start namenode
            yarn --daemon start resourcemanager

        else 
            echo "-- Take action $DIR is not Empty --"

            sleep 5
            
            hdfs --daemon start namenode
            yarn --daemon start resourcemanager

        fi

    else

        echo "-- Not first container startup --"
        sleep 5

        hdfs --daemon start namenode
        yarn --daemon start resourcemanager

    fi

else

    hdfs --daemon start datanode
    yarn --daemon start nodemanager 

fi

while :; do sleep 2073600; done