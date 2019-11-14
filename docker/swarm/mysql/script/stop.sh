#!/bin/bash
#author: zeping lai

source ./conf.sh

docker service rm ${mysql_master_service_name}
docker service rm ${mysql_slave_service_name}

docker config rm ${mysql_master_service_name}
docker config rm ${mysql_slave_service_name}
