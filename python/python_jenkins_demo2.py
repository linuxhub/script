#!/usr/bin/env python
#encoding:utf8
#author: zeping lai

# pip install python-jenkins
# http://www.cnblogs.com/znicy/p/5498609.html

import jenkins

url = 'http://192.168.6.3:8080'
username = 'admin'
password = '88888'

job_name = "www.linuxhub.org"

#实例化jenkins对象
server = jenkins.Jenkins(url,username,password)

# 获取下一项目构建号
next_build_number = server.get_job_info(job_name)['nextBuildNumber']

#构建项目
output =  server.build_job(job_name)

#定时10秒
from time import sleep; sleep(10)

build_info = server.get_build_info(job_name,next_build_number)

status =  build_info['result']

if status == "SUCCESS":
    print "构建成功：%s | 构建项目编号：%s" %(job_name,next_build_number)
else:
    print "构建出错: %s" % job_name

