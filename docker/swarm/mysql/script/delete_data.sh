#!/bin/bash
#author: zeping lai

source ./conf.sh

ssh -p 9528 root@${master_node_ip} rm -rf /data/mysql/${mysql_master}
ssh -p 9528 root@${slave_node_ip} rm -rf /data/mysql/${mysql_slave}

