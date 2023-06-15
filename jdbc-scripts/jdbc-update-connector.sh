#!/bin/bash

CONNECTOR_NAME="timeseriesconnector6"

curl -i -X PUT \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  http://localhost:8085/connectors/$CONNECTOR_NAME/config \
  -d '{
    "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
    "tasks.max": "1",
    "topics": "timeseriestopic5",
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "key.converter.schemas.enable": "true",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": "true",
    "auto.create": "true",
    "transforms": "Flatten",
    "transforms.Flatten.type": "org.apache.kafka.connect.transforms.Flatten$Value",
    "transforms.Flatten.delimiter": "_",
    "connection.url": "jdbc:postgresql://13.127.168.125:5432/kafka_data",
    "connection.user": "postgres",
    "connection.password": "dsw7AV5s49oS",
    "insert.mode": "insert",
    "batch.size": "2",
    "table.name.format": "sensor_data",
    "pk.mode": "none",
    "pk.fields": "id",
    "db.timezone": "Asia/Kolkata"
  }'

