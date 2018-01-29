#!/bin/bash
#author: www.linuxhub.org
#version v3.4.6
#自动安装: wget -q -O - https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/mongodb.install.sh | bash


#下载目录
down_dir=/data/down

if [ ! -d "$down_dir" ];then
	mkdir -p $down_dir
fi

#下载部署
cd $down_dir
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-rhel70-3.4.6.tgz

tar zxvf mongodb-linux-x86_64-rhel70-3.4.6.tgz
mv mongodb-linux-x86_64-rhel70-3.4.6 /usr/local/mongodb


#环境变量
echo "export PATH=\"\$PATH:/usr/local/mongodb/bin\"" >> /etc/profile
source /etc/profile


#创建程序目录
mkdir -p /usr/local/mongodb/conf    #配置文件目录
mkdir -p /data/mongodb              #数据目录
mkdir -p /data/logs/mongodb         #日志目录


#下载配置文件
curl https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/mongod.conf -o /usr/local/mongodb/conf/mongod.conf --progress

#下载服务脚本
curl https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/mongodb.service.sh -o /etc/init.d/mongodb --progress
chmod +x /etc/init.d/mongodb
chkconfig mongodb on

#启动服务
/etc/init.d/mongodb start