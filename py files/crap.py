import requests
import json

temp = ""
for x in "X9900990":
	# sprint(x)
	if x.isdigit():
		temp = temp + x
print (type(temp))

# API_KEY = "50732aac0d96a678b460b22c6eb07225"
yahoo = "http://api.upcdatabase.org/json/" + API_KEY + "/" + "1600029651"
getRequest = requests.get(yahoo)
parsed_json = json.loads(getRequest.text)
print(getRequest.text)