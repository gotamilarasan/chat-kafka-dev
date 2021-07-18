# chat-kafka-dev

This repo has configuration to set up chat Kafka dev environment with same version as production 2.1.1.

## Prerequisite
 - Docker

## Setup
 - Clone this repository
 - Run `./start.sh` script. This will create 3 broker Kafka cluster as docker containers.
 - The docker image is built based on Ubuntu 18.04 base image with kafka version 2.1.1 installed.
 - Run `docker ps` to see the containers with name kafka-1,2,3 has come up properly.
 - Zookeeper is configured in each of the broker.

## Listeners
Since we run all brokers on same base host with `host` networking mode, each broker listens on same interface but different ports.
Kafka: `localhost:19092,localhost:29092,localhost:39092`
Zookeeper: `localhost:12181,localhost:22181,localhost:32181`

## Produce/consume messages

If you want to use Kafka CLI tools to produce/consume messages:
 - Start the cluster with `./start.sh`
 - Exec into one of the container - `docker exec -it kafka-1 bash`
 - To create a topic - `kafka-topics --zookeeper=localhost:12181 --create --topic test --partitions 2 --replication-factor 2`
 - To list topics - `kafka-topics --zookeeper=localhost:12181 --list`
 - To produce - `kafka-console-producer --broker-list=localhost:19092,localhost:29092,localhost:39092 --topic test-1`
 - To consume - `kafka-console-consumer --bootstrap-server=localhost:19092,localhost:29092,localhost:39092 --topic test-1 --from-beginning`

## Destroy
To stop the cluster, just stop the docker containers - `docker stop kafka-{1,2,3}`.
To destroy the cluster, remove the docker container - `docker rm -f kafka-{1,2,3}`.
Kafka topic logs and zookeeper metadata are stored under `data` volumes, that needs to be cleaned up manually.
