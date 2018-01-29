#!/bin/bash
#author: www.linuxhub.org
#redis-4.0.1
#自动安装: wget -q -O - https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/redis.install.sh | bash


#组件
yum install gcc -y

#创建目录
mkdir -p /data/down
mkdir -p /usr/local/redis/bin/
mkdir -p /usr/local/redis/conf/
mkdir -p /data/logs/redis/
mkdir -p /data/redis

#下载
cd /data/down
wget http://download.redis.io/releases/redis-4.0.1.tar.gz

#编译安装
tar zxvf redis-4.0.1.tar.gz 
cd redis-4.0.1/
make MALLOC=libc
make install
cp redis.conf /usr/local/redis/conf/redis.conf.old
cd src
mv {redis-benchmark,redis-check-aof,redis-check-rdb,redis-trib.rb,redis-sentinel,redis-cli,redis-server} /usr/local/redis/bin/

#环境变量设置
echo "export PATH=\"\$PATH:/usr/local/redis/bin\"" >> /etc/profile
source /etc/profile

#下载配置文件
curl https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/redis.conf -o /usr/local/redis/conf/redis.conf --progress

#下载服务脚本
curl https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/redis.service.sh -o /etc/init.d/redis --progress
chmod +x /etc/init.d/redis
chkconfig redis on

#启动服务
/etc/init.d/redis start
echo "info" | redis-cli