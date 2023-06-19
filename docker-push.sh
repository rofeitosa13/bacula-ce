#!/bin/bash

echo "PUSH para Docker Hub iniciado."
sleep 1
docker push rofeitosa/bacula-base:13.0.2
sleep 1
docker push rofeitosa/bacula-director:13.0.2
sleep 1
docker push rofeitosa/bacula-catalog:13.0.2
sleep 1
docker push rofeitosa/bacula-storage:13.0.2
sleep 1
docker push rofeitosa/bacula-client:13.0.2
sleep 1
docker push rofeitosa/baculum-api:11.0.6
sleep 1
docker push rofeitosa/baculum-web:11.0.6
sleep 1
echo "PUSH para o Docker Hub finalizado!"
