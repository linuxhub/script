#!/usr/bin/env python
#encoding:utf8
#author: zeping lai

#Python使用urllib2模块获取API接口access_token

# 官方样例：
# curl -X POST https://api.linuxhub.org/user/login -d
# '{
#    "username": "foo@bar.com",
#    "password": "foobar"
# }'

import json
import urllib2

url = "https://api.linuxhub.org/user/login"
params = {'username': 'foo@bar.com', 'password': 'foobar'}
headers = {'Content-Type': 'application/json'}

params = json.dumps(params)
req = urllib2.Request(url,params,headers)
f = urllib2.urlopen(req)
response = f.read()
f.close()

res = json.loads(response)
print res['access_token']
