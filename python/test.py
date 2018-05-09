 import requests

r = s.get('http://127.0.0.1:8080/')
r = s.post('http://127.0.0.1:8080/')
r = s.get('http://127.0.0.1:8080/')
r = s.post('http://127.0.0.1:8080/api', params={"computer_ip":"123.123.123.123","username":"ukaihui","cmd":"testhttp"})

