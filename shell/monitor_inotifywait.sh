#!/bin/bash
# zeping lai
# monitor_inotifywait.sh
# */5 * * * * /bin/bash /data/app/monitor_inotifywait.sh
# 进程检测自愈脚本

LOGS_FILE=/data/logs/script/monitor_inotifywait/monitor_inotifywait.log

SCRIPT_FILE_A=/data/app/csm_html_distribution.sh
SCRIPT_FILE_B=/data/app/csm_html_distribution_HK.sh

SCRIPT_FILE_LIST[1]=$SCRIPT_FILE_A
SCRIPT_FILE_LIST[2]=$SCRIPT_FILE_B

for SCRIPT_FILE in ${SCRIPT_FILE_LIST[*]}
do
        P_NUM=`ps aux | grep -v grep | grep "$SCRIPT_FILE" | wc -l`
        if [ $P_NUM -gt 0 ];then
            continue
        fi

        echo "" >> $LOGS_FILE
        echo "$(date +%Y-%m-%d' '%H:%M:%S) | warning | $SCRIPT_FILE " >> $LOGS_FILE
        
        if [ "$SCRIPT_FILE" == "$SCRIPT_FILE_A" ];then
            /etc/init.d/inotifywait restart > /dev/null
            echo "$(date +%Y-%m-%d' '%H:%M:%S) | restart | $SCRIPT_FILE " >> $LOGS_FILE
        fi

        if [ "$SCRIPT_FILE" == "$SCRIPT_FILE_B" ];then
            /etc/init.d/inotifywait_HK restart > /dev/null
            echo "$(date +%Y-%m-%d' '%H:%M:%S) | restart | $SCRIPT_FILE " >> $LOGS_FILE
        fi
done


