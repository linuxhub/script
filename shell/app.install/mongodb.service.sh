#!/bin/bash
#chkconfig: 2345 64 36
#description: mongodb

NAME=mongodb
APP_DIR=/usr/local/mongodb
APP_BIN=$APP_DIR/bin/mongod
APP_CONF=$APP_DIR/conf/mongod.conf


PID=`ps -efl | grep -v grep |grep -i "${NAME}" | grep -v "/etc/init.d/"  | awk '{print $4}'`


case "$1" in
    start)
		if [ $PID ];then
	        echo "$NAME (pid $PID) already running."
			exit 1
		fi
        echo 'never' > /sys/kernel/mm/transparent_hugepage/enabled
        echo 'never' > /sys/kernel/mm/transparent_hugepage/defrag
		$APP_BIN -f $APP_CONF
		if [ "$?" != 0 ] ; then
			echo " failed"
			exit 1
		else
			echo " done"
		fi
        ;;
    stop)
	
		if [ ! $PID ]; then
			echo "$NAME is not running."
			exit 1
		fi
		$APP_BIN -f $APP_CONF --shutdown
		if [ "$?" != 0 ] ; then
			echo " failed"
			exit 1
		else
			echo " done"
		fi

        ;;
    status)
		if [ $PID ];then
			netstat -tnpl | grep $PID
		else
			echo "$NAME is stopped"
			exit 0
		fi

        ;;
    restart)
        $0 stop
        $0 start
        ;;
    *)
        echo "Usage: $SCRIPTNAME {start|stop|status}"
        ;;
esac