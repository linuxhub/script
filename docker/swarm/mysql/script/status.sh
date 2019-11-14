#!/bin/bash
#author: zeping lai

source ./conf.sh

# Docker Swarm
service_name=$mysql_master_service_name
service_id=`docker service ps $service_name --format "{{.ID}}"`
task_id=`docker ps | grep $service_id | head -n 1 | awk '{print $1}'`

# master
echo -e "\n----- ${mysql_master_service_name} -------"
docker exec -it $task_id \
mysql --host=${mysql_master_service_name} --user=${db_root_user} --password=${db_root_pwd} \
--execute="show master status \G;"

echo -e "\n---- slave conn -----"
docker exec -it $task_id \
mysql --host=${mysql_master_service_name} --user=${db_root_user} --password=${db_root_pwd} \
--execute="show slave hosts;"

# slvae
echo -e "\n----- ${mysql_slave_service_name} -------"
docker exec -it $task_id \
mysql --host=${mysql_slave_service_name} --user=${db_root_user} --password=${db_root_pwd} \
--execute="show slave status \G;"
