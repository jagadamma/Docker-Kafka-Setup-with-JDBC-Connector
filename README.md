# Docker-Kafka-Setup-with-JDBC-Connector
- Docker Compose Stack for kafka installation and JDBC Connector Scripts for TimescaleDB.
- The stack includes Kafka Components like Kafka, Zookeeper, Kafka Connector ect. It also includes the Kafka Exporter that exports the metrics to prometheus.
- Also Contains the guide on how to setup the AKQH(GUI Based Kafka Manager)

## Deployment Steps.
- Clone the Repository
- in docker-compose.yml update the "Instance-IP-Here" field with your public or private instance ip
  
```
 KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092,PLAINTEXT_HOST://localhost:29092,PLAINTEXT_REMOTE_HOST://<Instance-IP-Here>:29093
```

- Create volumes to persist the container data by running following commands

```
 # Create dirs for Kafka / ZK data.
sudo mkdir -p /vol1/zk-data
sudo mkdir -p /vol2/zk-txn-logs
sudo mkdir -p /vol3/kafka-data

# Make sure the user has the read and write permissions.
sudo chown -R 1000:1000 /vol1/zk-data
sudo chown -R 1000:1000 /vol2/zk-txn-logs
sudo chown -R 1000:1000 /vol3/kafka-data
```
  
- Save and start the stack by running following command
```
 docker-compose up -d
```

## Create a new Kafka topic (Replace the topic name of your choice)
```
 docker exec -it kafka kafka-topics --create --topic topic_name --partitions 1 --replication-factor 1 --bootstrap-server localhost:9092
```

## Check Messages coming to a topic (replace the topic name)
```
 docker exec -it kafka kafka-console-consumer --topic topic_name --bootstrap-server localhost:9092 --from-beginning
```

## Some other kafka commands
```
kafka-console-producer --topic topic_name --bootstrap-server localhost:9092
kafka-topics --bootstrap-server localhost:9092 --list
kafka-topics --bootstrap-server localhost:9092 --delete --topic topic_name
```

## JDBC Connector

## Create a new JDBC Connector for timescaledb
- Change the DB configs like address, table and the password, Topic name, and connector name accordingly
- Run the following command to execute the connector script from the kafka directory (/home/ubuntu/kafka)
```
 ./jdbc-scripts/jdbc-timescaledb.sh
```

## Update the connector configs
- After making changes in connector configs
- Run the following command to execute the connector update script from the kafka directory (/home/ubuntu/kafka)
```
 ./jdbc-scripts/jdbc-update-connector.sh
```

## Check the status of connector
- Replace the localhost with kafka server IP if running from local machine
```
curl -X GET http://localhost:8085/connectors/connector-name/status
```
## Stop or restart the connector
```
curl -X POST http://localhost:8085/connectors/connector-name/pause
curl -X POST http://localhost:8085/connectors/connector-name/restart
```
## Delete a connector
```
curl -X DELETE http://localhost:8085/connectors/connector-name
```

## Check the Kafka Connect Logs to troubleshoot the connector related issues
```
docker logs kafkaconnect -f
```

## Setup AKHQ 
### AKHQ is a GUI tool for Apache Kafka to manage topics, topics data, consumers group, schema registry, connect and more.

- in the akqh-docker.yml, replace the localhost with public ip of your kafka server (kafka broker, schema registry and kafka connect), change ports also if using the different ports.
- spin-up the AKHQ container by
```
docker-compose -f akhq-docker.yml up -d
```
- access the dashboard at publicip:8080
  




