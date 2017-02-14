#!/bin/bash
# www.linxuhb.org
# install.MySQL5.6.Centos6.5.sh
# MySQL 5.6 安装脚本



# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install MySQL"
    exit 1
fi



# 目录-程序包下载
down_dir=/data/down

# 目录-程序安装
mysql_dir=/usr/local/mysql

# 目录-数据存储
mysql_data=/data/mysql/data

# 数据库root用户密码
mysqlrootpwd=www.linuxhub.org

# 检查删除原来的MySQL
rpm -qa|grep mysql
rpm -e mysql
yum -y remove mysql-server mysql mysql-libs

# 创建目录
mkdir -p $down_dir
mkdir -p $mysql_data

# 下载
cd $down_dir
wget https://cdn.mysql.com//Downloads/MySQL-5.6/mysql-5.6.35.tar.gz

# 添加程序运行用户
groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql

# 组件
yum -y install ncurses-devel bison openssl openssl-devel 
yum -y install gcc-c++ libstdc++-devel cmake


# 源码安装
tar zxvf mysql-5.6.35.tar.gz
cd mysql-5.6.35

cmake \
-DCMAKE_INSTALL_PREFIX=$mysql_dir \
-DMYSQL_DATADIR=$mysql_data \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DWITH_READLINE=1 \
-DWITH_SSL=system \
-DWITH_ZLIB=system \
-DWITH_EMBEDDED_SERVER=1 \
-DENABLED_LOCAL_INFILE=1 

make && make install


# 拷贝主配置文件
mv /etc/my.cnf /etc/my.cnf.bak
cp $mysql_dir/support-files/my-default.cnf  /etc/my.cnf


# 添加到配置文件
# port = 3306
# socket=/tmp/mysql.sock
# user=mysql
# datadir=/data/mysql/data

sed -i 's/\[mysqld\]/& \ndatadir=\/data\/mysql\/data/' /etc/my.cnf
sed -i 's/\[mysqld\]/& \nuser=mysql/' /etc/my.cnf
sed -i 's/\[mysqld\]/& \nsocket=\/tmp\/mysql.sock/'  /etc/my.cnf
sed -i 's/\[mysqld\]/& \nport =3306/' /etc/my.cnf


# 初始化数据库
cd $mysql_dir
scripts/mysql_install_db --user=mysql --basedir=$mysql_dir --datadir=$mysql_data


# 服务启动脚本 
cp $mysql_dir/support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld


# 添加到系统服务并开机自启
chkconfig --add mysqld
chkconfig --level 345 mysqld on

# 启动服务
/etc/init.d/mysqld start


# 环境变量
ln -s /usr/local/mysql/bin/mysql /usr/bin/mysql
ln -s /usr/local/mysql/bin/mysqldump /usr/bin/mysqldump
ln -s /usr/local/mysql/bin/myisamchk /usr/bin/myisamchk
ln -s /usr/local/mysql/bin/mysqld_safe /usr/bin/mysqld_safe

# 设置数据库root用户密码
/usr/local/mysql/bin/mysqladmin -u root password $mysqlrootpwd


echo "\n======== MySQL 安装完成  ==================="
echo "安装目录: $mysql_dir"
echo "数据目录: $mysql_data"
echo "root密码: $mysqlrootpwd"
echo "============================================="
