#!/bin/bash
#author: zeping lai

# docker swarm node
master_node="GZ-ZE-SWARM-110"
slave_node="GZ-ZE-SWARM-120"

master_node_ip="172.18.221.110"
slave_node_ip="172.18.221.120"

# DockerSwarm namespace
namespace="prd"

# DockerSwarm集群服务名称
mysql_master="ze-mysql"
mysql_slave="ze-mysql-slave"

mysql_master_service_name="${namespace}_${mysql_master}"
mysql_slave_service_name="${namespace}_${mysql_slave}"

# 数据库管理员账号
db_root_user="root"
db_root_pwd="12345678"

# 主从数据同步账号
db_repl_user="repl"
db_repl_pwd="87654321"

