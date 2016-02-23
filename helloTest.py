import requests
r = requests.post("http://127.0.0.1:5000/upload", files={"image": open('test1.jpg', 'rb')})
# r = requests.post("http://phreshhackillinois.herokuapp.com", files={"image": open('test1.jpg', 'rb')})

#print(r.status_code, r.text)
print r.text