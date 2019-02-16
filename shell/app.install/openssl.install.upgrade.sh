#!/bin/bash
#author: www.linuxhub.org
#Version: OpenSSL_1_1_1a
#自动安装: wget -q -O - https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/openssl.install.upgrade.sh | bash

openssl_version=`openssl version | cut -d " " -f2`
if [ $openssl_version == "1.1.1a" ];then
   echo "当时已经是最新版本: $openssl_version ,不需要升级。"  
   exit
else
  echo "当前版本: $openssl_version ,不是最新的。"
  echo "升级版本中...."
fi

mkdir -p /data/down && cd /data/down
wget -O openssl-OpenSSL_1_1_1a.tar.gz https://github.com/openssl/openssl/archive/OpenSSL_1_1_1a.tar.gz
tar zxvf openssl-OpenSSL_1_1_1a.tar.gz 
cd openssl-OpenSSL_1_1_1a
./config --prefix=/usr --shared
make
make install

echo "升级完成"
openssl_version=`openssl version | cut -d " " -f2`
echo "当前版本： $openssl_version"
