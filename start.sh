#!/bin/bash

# build docker image
docker build -t chat-kafka .

# initialize data directories
mkdir -p data/kafka{1,2,3} data/zookeeper{1,2,3}

# Set up zookeeper server IDs
echo "1" > data/zookeeper1/myid
echo "2" > data/zookeeper2/myid
echo "3" > data/zookeeper3/myid

COMMON_PARAMS="-d --net=host --tmpfs /tmp --tmpfs /run --tmpfs /run/lock -v /sys/fs/cgroup:/sys/fs/cgroup:ro"

# Launch kafka broker 1
docker run --name kafka-1 ${COMMON_PARAMS} -v ${PWD}/config/kafka/broker1.properties:/etc/kafka/server.properties:ro -v ${PWD}/config/kafka/zookeeper1.properties:/etc/kafka/zookeeper.properties:ro  \
-v ${PWD}/data/zookeeper1:/var/lib/zookeeper \
-v ${PWD}/data/kafka1:/var/lib/kafka \
-v ${PWD}/config/systemd/kafka1.service:/lib/systemd/system/kafka.service:ro \
chat-kafka

# Launch kafka broker 2
docker run --name kafka-2 ${COMMON_PARAMS} -v ${PWD}/config/kafka/broker2.properties:/etc/kafka/server.properties:ro -v ${PWD}/config/kafka/zookeeper2.properties:/etc/kafka/zookeeper.properties:ro  \
-v ${PWD}/data/zookeeper2:/var/lib/zookeeper \
-v ${PWD}/data/kafka2:/var/lib/kafka \
-v ${PWD}/config/systemd/kafka2.service:/lib/systemd/system/kafka.service:ro \
chat-kafka

# Launch kafka broker 3
docker run --name kafka-3 ${COMMON_PARAMS} -v ${PWD}/config/kafka/broker3.properties:/etc/kafka/server.properties:ro -v ${PWD}/config/kafka/zookeeper3.properties:/etc/kafka/zookeeper.properties:ro  \
-v ${PWD}/data/zookeeper3:/var/lib/zookeeper \
-v ${PWD}/data/kafka3:/var/lib/kafka \
-v ${PWD}/config/systemd/kafka3.service:/lib/systemd/system/kafka.service:ro \
chat-kafka

# start broker1
docker exec kafka-1 /start_kafka.sh

# start broker2
docker exec kafka-2 /start_kafka.sh

# start broker3
docker exec kafka-3 /start_kafka.sh
