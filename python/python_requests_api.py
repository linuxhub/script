#!/usr/bin/env python
#encoding:utf8
#author: zeping lai
#Python使用requests模块获取API接口access_token

# 官方样例：
# curl -X POST https://api.linuxhub.org/user/login -d
# '{
#    "username": "foo@bar.com",
#    "password": "foobar"
# }'

import requesrequeststs
import json

url = "https://api.linuxhub.org/user/login"
params = {'username': 'foo@bar.com', 'password': 'foobar'}
headers = {'content-type': 'application/json'}
params = json.dumps(params)
r = requests.post(url,params,headers)
res = json.loads(r.content)
print res['access_token']
