#!/bin/bash
# author: www.linuxhub.cn
# name:  二进制自动安装 docker
#
# 自动安装: wget -q -O - https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/docker.install.sh | bash

# docker 版本
docker_ver="18.09.6"


# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install Docker"
    exit 1
fi

echo -e "\n1.创建目录"
mkdir -p /data/down
mkdir -p /usr/local/docker/bin
mkdir -p /data/docker
mkdir -p /etc/docker

echo -e "\n2.下载部署"
cd /data/down
wget https://download.docker.com/linux/static/stable/x86_64/docker-${docker_ver}.tgz
tar -xvf docker-${docker_ver}.tgz
mv docker/* /usr/local/docker/bin/
ln -s /usr/local/docker/bin/docker /usr/local/bin/
rm -rf docker-${docker_ver}.tgz

echo -e "\n3.环境变量"
echo "export PATH=\"\$PATH:/usr/local/docker/bin\"" >> /etc/profile
source /etc/profile


echo -e "\n4.服务进程管理配置"
cat > /etc/systemd/system/docker.service <<"EOF"
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.io

[Service]
Environment="PATH=/usr/local/docker/bin:/bin:/sbin:/usr/bin:/usr/sbin"
EnvironmentFile=-/run/flannel/docker
ExecStart=/usr/local/docker/bin/dockerd --log-level=error $DOCKER_NETWORK_OPTIONS
ExecReload=/bin/kill -s HUP $MAINPID
Restart=on-failure
RestartSec=5
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF

echo -e "\n5.Docker配置"
cat > /etc/docker/daemon.json <<"EOF"
{
    "data-root": "/data/docker",
    "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2376"]
}
EOF

echo -e "\n6.启动服务"
systemctl daemon-reload
systemctl restart docker
systemctl enable docker

echo -e "\n7.安装完成"
docker --version
netstat -nltp | grep dockerd
