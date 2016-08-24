#!/bin/bash
# zeping lai
# rsync_inotifywait.sh 
# 时实同步分发到各个城市节点主机对应的域名下的某个目录

TMS_HTML=/data/TMS/cmsHtml

RSYNC_USER=tms
RSYNC_PAS_FILE=/root/rsync/rsync.cms.pas
RSYNC_PORT=9000

GZ_NODE=192.168.100.200
BJ_NODE=192.168.100.201
DG_NODE=192.168.100.202
DG_NODE_B=192.168.100.203

TOTAL_NODE[1]=$GZ_NODE
TOTAL_NODE[2]=$DG_NODE
TOTAL_NODE[3]=$BJ_NODE

# 域名列表 
DOMAIN_LIST="www.linuxhub.cn www.linuxhub.org m.linuxhub.org"

# 分发到各个节点 
function DISTRIBUTION()
{
  for DOMAIN in $DOMAIN_LIST
  do
    REMOTE_DIR=wwwmain/$DOMAIN/cmsHtml
  
    for NODE in ${TOTAL_NODE[*]}
    do
      echo "/usr/bin/rsync --port=$RSYNC_PORT -vzrtopg --delete --progress --password-file=$RSYNC_PAS_FILE $TMS_HTML/$DOMAIN/ $RSYNC_USER@$NODE::$REMOTE_DIR"
    done 
  done
}

#3g.linuxhub.cn
function LINUXHUB_3G()
{
  DOMAIN=3g.linuxhub.cn
  REMOTE_DIR=wwwmain/new.3g.linuxhub.cn2/$DOMAIN/cmsHtml

  for NODE in ${TOTAL_NODE[*]}
  do
      echo "/usr/bin/rsync --port=$RSYNC_PORT -vzrtopg --delete --progress --password-file=$RSYNC_PAS_FILE $TMS_HTML/$DOMAIN/ $RSYNC_USER@$NODE::$REMOTE_DIR"
  done
}


#blog.linuxhub.com
function LINUXHUB_BLOG()
{

  DOMAIN=4ever.linuxhub.com
  REMOTE_DIR=wwwmain/$DOMAIN/cmsHtml
  TOTAL_NODE[4]=$DG_NODE_B
  
  for NODE in ${TOTAL_NODE[*]}
  do
      echo "/usr/bin/rsync --port=$RSYNC_PORT -vzrtopg --delete --progress --password-file=$RSYNC_PAS_FILE $TMS_HTML/$DOMAIN/ $RSYNC_USER@$NODE::$REMOTE_DIR"
  done
}


/usr/bin/inotifywait -mrq --timefmt '%d/%m/%y %H:%M' --format '%T %w%f%e' -e modify,delete,create,attrib $TMS_HTML \
|while read files
do
    DISTRIBUTION
    LINUXHUB_3G
    LINUXHUB_BLOG
    #echo "${files} was rsynced" >> /tmp/rsync.log 2>&1
done
