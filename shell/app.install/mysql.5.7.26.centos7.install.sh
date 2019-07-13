
#!/bin/bash
# authro: www.linxuhb.cn
# name:  二进制安装 MySQL
# ver: MySQL 5.7.26
# 自动安装: wget -q -O - https://raw.githubusercontent.com/linuxhub/script/master/shell/app.install/mysql.5.7.26.centos7.install.sh | bash


# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use root to install MySQL"
    exit 1
fi

# 数据库root用户密码
mysqlrootpwd="www.linuxhub.org"

echo -e "\n0.检查删除原来的MySQL"
rpm -qa|grep mysql
rpm -e mysql
yum -y remove mysql-server mysql mysql-libs

echo -e "\n1.组件安装"
yum -y install ncurses-devel bison openssl openssl-devel
yum -y install gcc-c++ libstdc++-devel cmake autoconf
yum -y install zlib zlib-devel pcre pcre-devel libaio-devel.x86_64

echo -e "\n2.目录创建"
down_dir="/data/down"         # 目录-程序包下载
mysql_data="/data/mysql/data" # 目录-数据存储
mysql_dir="/usr/local/mysql" # 目录-程序安装

CheckDir(){
	if [ ! -d "$1" ]; then
        mkdir -p $1
  	fi
}

CheckDir $down_dir
CheckDir $mysql_data

echo -e "\n3.下载与部署二进制文件"
cd $down_dir
wget https://cdn.mysql.com//Downloads/MySQL-5.7/mysql-5.7.26-linux-glibc2.12-x86_64.tar.gz
tar -zxvf  mysql-5.7.26-linux-glibc2.12-x86_64.tar.gz
mv mysql-5.7.26-linux-glibc2.12-x86_64 $mysql_dir

ln -s $mysql_dir/bin/mysql /usr/bin/mysql
ln -s $mysql_dir/bin/mysqldump /usr/bin/mysqldump
ln -s $mysql_dir/bin/myisamchk /usr/bin/myisamchk
ln -s $mysql_dir/bin/mysqld_safe /usr/bin/mysqld_safe

echo -e "\n4.添加程序运行用户与授权"
groupadd mysql
useradd -s /sbin/nologin -M -g mysql mysql

chown -R mysql:mysql {$mysql_dir,$mysql_data}
chmod -R 750 {$mysql_dir,$mysql_data,}

echo -e "\n5.生成配置文件"
cat > /etc/my.cnf << EOF
[client]
port = 3306
socket = /tmp/mysql.sock

[mysqld]
port = 3306
user = mysql
basedir = $mysql_dir
datadir = $mysql_data
socket = /tmp/mysql.sock
lower_case_table_names = 1
character-set-server = utf8mb4
default_storage_engine = innodb
max_connections = 1000
max_connect_errors = 1000
table_open_cache = 1024
max_allowed_packet = 128M
open_files_limit = 65535
EOF

echo -e "\n6.初始化数据库" 
$mysql_dir/bin/mysqld --defaults-file=/etc/my.cnf --initialize-insecure --datadir=$mysql_data --basedir=$mysql_dir --user=mysql

echo -e "\n7.拷贝服务启动脚本"
cp $mysql_dir/support-files/mysql.server /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld

echo -e "\n8.添加到系统服务并开机自启"
chkconfig --add mysqld
chkconfig --level 345 mysqld on

echo -e "\n9.启动服务"
/etc/init.d/mysqld start

echo -e "\n10.设置数据库root用户密码"
$mysql_dir/bin/mysqladmin -u root password $mysqlrootpwd

echo "\n======== MySQL 安装完成  ==================="
echo "安装目录: $mysql_dir"
echo "数据目录: $mysql_data"
echo "服务管理： /etc/init.d/mysqld"
echo "root密码: $mysqlrootpwd"
echo "连接数据:  mysql -rroot -p${mysqlrootpwd}"
echo "============================================="
