#!/bin/bash

systemctl daemon-reload && systemctl start confluent-zookeeper && systemctl start kafka
