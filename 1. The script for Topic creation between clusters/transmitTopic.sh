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