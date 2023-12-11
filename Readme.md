# The Kafka knowledge base
>This repo created for Apache Kafka knowledge scripts,tools and etc_

![N|Solid](https://koraypeker.com/wp-content/uploads/2020/04/apacheKafka.jpeg)


1. The script for Topic creation between clusters

## 1. The script for Topic creation between clusters

The script which analyze all topics in server create new topic to destination server

```sh
#!/bin/bash

sourceKafka="" #source destination and port
targetKafka="" #target destination and port
pathKafka="/Products/App/kafka_2.13-3.0.2/bin" #source kafka patha

sourceTopics=$($pathKafka/kafka-topics.sh --bootstrap-server $sourceKafka --list)

for topic in $sourceTopics; do
  echo "İşlenen topic: $topic"
  topicDetails=$($pathKafka/kafka-topics.sh --bootstrap-server $sourceKafka --topic $topic --describe)
  partitionCount=$(echo "$topicDetails" | grep -o 'PartitionCount: [0-9]*' | awk '{print $2}')
  replicationFactor=$(echo "$topicDetails" | grep -o 'ReplicationFactor: [0-9]*' | awk '{print $2}')
  $pathKafka/kafka-topics.sh --bootstrap-server $targetKafka --create --topic $topic --partitions $partitionCount --replication-factor $replicationFactor
done
```


