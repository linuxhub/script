#!/usr/bin/env python
#encoding:utf8
#author: zeping lai
 
# pip install python-jenkins
 
 
import jenkins
 
url = 'http://192.168.9.120:8080'
username = 'admin'
password = '888888'
 
#实例化jenkins对象
server = jenkins.Jenkins(url,username,password)
 
job_name = "www.linuxhub.org"
 
#构建项目
print server.build_job(job_name)
 
#获取项目相关信息
#print server.get_job_info(job_name)
 
# 获取项目最后次构建号
build_number = server.get_job_info(job_name)['lastBuild']['number']
print build_number
 
# 获取下一项目构建号
next_build_number = server.get_job_info(job_name)['nextBuildNumber']
print next_build_number
 
#某次构建的执行结果状态
print server.get_build_info(job_name,build_number)['result']
 
#是否构建中
print server.get_build_info(job_name,build_number)['building']
