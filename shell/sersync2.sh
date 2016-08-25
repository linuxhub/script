#!/bin/bash
# zeping lai
# chmod +x /etc/init.d/sersync2
# chkconfig sersync2 on
# sersync2 服务脚本

### BEGIN INIT INFO
# Provides:          sersync2
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the sersync2 server
# Description:       starts sersync2 start-stop-daemon
### END INIT INFO

# /usr/local/bin/sersync2 -r -d -o /usr/local/sersync/conf/upload_conf.xml
# /usr/local/bin/sersync2 -r -d -o /usr/local/sersync/conf/public_conf.xml


CONF_UPLOAD=/usr/local/sersync/conf/upload_conf.xml
CONF_PUBLIC=/usr/local/sersync/conf/public_conf.xml


CONF_LIST[1]=$CONF_UPLOAD
CONF_LIST[2]=$CONF_PUBLIC


case "$1" in
    start )

            for CONF in ${CONF_LIST[*]}
            do
                conf_name=`echo $CONF | awk -F '/' '{print $NF}' `
                echo -n "Stating $conf_name....."   

                P_NUM=`ps aux | grep -v grep | grep "$CONF" | wc -l`
                if [ $P_NUM -gt 0 ];then
                    echo " alter running. "
                    continue
                fi
            
                /usr/bin/nohup /usr/local/bin/sersync2 -r -d -o $CONF > /dev/null 2>&1 &
                if [ "$?" != 0 ] ; then
                        echo " failed"
                        continue
                else
                        echo " done"
                fi

            done

        ;;

    stop )

            for CONF in ${CONF_LIST[*]}
            do

                conf_name=`echo $CONF | awk -F '/' '{print $NF}' `
                echo -n "Stoping $conf_name....."  

                P_NUM=`ps aux | grep -v grep | grep "$CONF" | wc -l`
                if [ $P_NUM -eq 0 ];then
                    echo " is not running."
                    continue
                fi

                ps -efl | grep -v grep |grep "$CONF" | awk '{print $4}'|xargs kill -s 9
                if [ "$?" != 0 ] ; then
                    echo " failed"
                    exit 1
                else
                    echo " done"
                fi
            done

         
        ;;

    status )
          
            for CONF in ${CONF_LIST[*]}
            do

                conf_name=`echo $CONF | awk -F '/' '{print $NF}' `
                echo -n "Status $conf_name....."  

                P_NUM=`ps aux | grep -v "grep" | grep "$CONF" | wc -l`
                if [ $P_NUM -gt 0 ];then
                    echo " alter running. "
                else
                    echo " is not running."   
                fi

            done
                
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
