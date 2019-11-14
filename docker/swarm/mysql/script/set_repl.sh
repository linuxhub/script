#!/bin/bash
#author: zeping lai

source ./conf.sh

# Docker Swarm
service_name=$mysql_master_service_name
service_id=`docker service ps $service_name --format "{{.ID}}"`
task_id=`docker ps | grep $service_id | head -n 1 | awk '{print $1}'`

# master
docker exec -it $task_id \
mysql --host=${mysql_master_service_name} --user=${db_root_user} --password=${db_root_pwd} \
--execute="GRANT REPLICATION SLAVE ON *.* TO \"${db_repl_user}\"@'%' IDENTIFIED BY \"${db_repl_pwd}\"; FLUSH PRIVILEGES;"


# slvae
docker exec -it $task_id \
mysql --host=${mysql_slave_service_name} --user=${db_root_user} --password=${db_root_pwd} \
--execute="CHANGE MASTER TO MASTER_HOST=\"${mysql_master_service_name}\", MASTER_USER=\"${db_repl_user}\", MASTER_PASSWORD=\"${db_repl_pwd}\", MASTER_AUTO_POSITION=1; START SLAVE;"
