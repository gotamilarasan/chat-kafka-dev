# chat-kafka-dev

This repo has connfiguration to set up chat Kafka dev environment with same version as production 2.1.1.

## Prerequisite
 - Docker

## Setup
 - Clone this repository
 - Run `start.sh` script. This will create 3 broker Kafka cluster as docker containers.
 - Zookeeper is configured in each of the broker.

## Produce/consume messages

If you want to use Kafka CLI tools to produce/consume messages:
 - Start the cluster with `start.sh`
 - Exec into one of the container - `docker exec -it kafka-1 bash`
 - To produce - `kafka-console-producer --bootstrap-server=localhost:19092 --topic <topic name>`
 - To consume - `kafka-console-consumer --bootstrap-server=localhost:19092 --topic <topic name>`

## Destroy
To stop the cluster, just stop the docker containers - `docker stop kafka-{1,2,3}`.
To destroy the cluster, remove the docker container - `docker rm -f kafka-{1,2,3}`.
Kafka topic logs and zookeeper metadata are stored under `data` volumes, that needs to be cleaned up manually.
