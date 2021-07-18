FROM jrei/systemd-ubuntu:18.04

RUN apt-get update

RUN apt-get install -y openjdk-8-jdk wget gnupg2 software-properties-common

RUN wget -qO - https://packages.confluent.io/deb/5.1/archive.key | apt-key add -

RUN add-apt-repository "deb [arch=amd64] https://packages.confluent.io/deb/5.1 stable main"

RUN apt-get update

RUN apt-get install -y confluent-kafka-2.11 confluent-platform-2.11 systemd net-tools vim 

VOLUME ["/var/lib/zookeeper", "/var/lib/kafka"]

ADD config/kafka/start_kafka.sh /start_kafka.sh

RUN chmod +x /start_kafka.sh
