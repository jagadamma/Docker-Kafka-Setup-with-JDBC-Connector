# Docker-Kafka-Setup-with-JDBC-Connector
Docker Compose Stack for kafka installation and JDBC Connector Scripts for TimescaleDB.

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
- Change the DB configs, Topic name, and connector name accordingly
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





