# Docker-Kafka-Setup-with-JDBC-Connector
Docker Compose Stack for kafka installation and JDBC Connector Scripts for TimescaleDB.

## SpinUp the Containers

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
- Run the following commands
```
 cd jdbc-scripts
./jdbc-timescaledb.sh
```

## Update the connector configs
- Run the following commands
```
 cd jdbc-scripts
./jdbc-update-connector.sh
```





