# -*- coding:utf-8 -*-

import requests
import json

url = 'http://172.22.44.55:8088/api'
s = json.dumps({"computer_ip":"123.123.123.123","username":"ukaihui","cmd":"testhttp"})
#r = requests.post(url, data=s)
r = requests.get(url)
print r.text