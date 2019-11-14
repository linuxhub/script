#!/bin/bash
#author: zeping lai
source ./conf.sh

ssh -p 9528 root@${master_node_ip} mkdir -p /data/mysql/${mysql_master}
ssh -p 9528 root@${slave_node_ip} mkdir -p /data/mysql/${mysql_slave}

# docker node update --label-add app="mysql" ${master_node}
# docker node update --label-add app="mysql-slave" ${slave_node}
