#!/bin/bash
#author: zeping lai

source ./conf.sh

sed -e "s/##mysql_master##/${mysql_master}/" \
-e "s/##mysql_slave##/${mysql_slave}/" \
-e "s/##db_root_pwd##/${db_root_pwd}/" \
../resources/docker-compose.yml.template > ../resources/docker-compose.yml


docker stack deploy -c ../resources/docker-compose.yml ${namespace}
