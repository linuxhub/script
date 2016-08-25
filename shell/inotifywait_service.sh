
#!/bin/bash
# zeping lai
# chmod +x /etc/init.d/inotifywait
# chkconfig inotifywait on

### BEGIN INIT INFO
# Provides:          inotifywait
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the inotifywait  server
# Description:       starts inotifywait start-stop-daemon
### END INIT INFO

NAME=inotifywait
SCRIPT_FILE=/data/app/cms_html_distribution.sh

case "$1" in
    start )
            echo -n "Stating $NAME....."
            P_NUM=`ps aux | grep -v grep | grep "$SCRIPT_FILE" | wc -l`
            if [ $P_NUM -gt 0 ];then
                echo " alter running."
                exit 1
            fi

            /usr/bin/nohup /bin/bash $SCRIPT_FILE > /dev/null 2>&1 &
            if [ "$?" != 0 ] ; then
                echo " failed"
                exit 1
            else
                echo " done"
            fi
        ;;

    stop )
            echo -n "Stoping $NAME..."
            P_NUM=`ps aux | grep -v grep | grep "$SCRIPT_FILE" | wc -l`
            if [ $P_NUM -eq 0 ];then
              echo " is not running."
              exit 1
            fi
            ps -efl | grep -v grep |grep "$SCRIPT_FILE" | awk '{print $4}'|xargs kill -s 9

            if [ "$?" != 0 ] ; then
                echo " failed"
                exit 1
            else
                echo " done"
            fi
        ;;

    status )
            P_NUM=`ps aux | grep -v "grep" | grep "$SCRIPT_FILE" | wc -l`
                if [ $P_NUM -gt 0 ];then
                     echo " already running."
                else
                     echo " is stopped"    
                fi
        ;;

    restart )
                $0 stop
                sleep 1
                $0 start
        ;;

    * )
                echo "Usage: $0 {start|stop|restart|status}"
                exit 1
        ;;    

esac




