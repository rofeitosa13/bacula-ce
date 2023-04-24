#!/bin/bash

echo "BUILD INICIADO!"

docker build -t rofeitosa/bacula-base:13.0.2 bacula-base/.
docker build -t rofeitosa/bacula-director:13.0.2 bacula-director/.
docker build -t rofeitosa/bacula-catalog:13.0.2 bacula-catalog/.
docker build -t rofeitosa/bacula-storage:13.0.2 bacula-storage/.
docker build -t rofeitosa/bacula-client:13.0.2 bacula-client/.
docker build -t rofeitosa/baculum-api:11.0.6 baculum-api/.
docker build -t rofeitosa/baculum-web:11.0.6 baculum-web/.

echo "BUILD FINALIZADO!"
