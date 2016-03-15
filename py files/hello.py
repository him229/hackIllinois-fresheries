from flask import Flask
from flask import request
from PIL import Image
import commands
import requests
import json

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
	#if request.method == 'POST':
	#    f = request.files['the_file']
	#   f.save('/var/www/uploads/uploaded_file.txt')
	imageData = request.form["image"]


	usrimg = Image.open(imageData)
	# Converting the image to greyscale.
	captcha = usrimg.convert('1')                               
	# Saving the image as tesseract can read.
	captcha.save('temp.bmp', dpi=(200,200))
	# Invoking tesseract from python to extract characters
	commands.getoutput('tesseract temp.bmp data')
	# Reading the output generated in data.txt
	# with open('data.txt', 'r') as data:
	#     print data.readline().strip()

	with open("data.txt", "r") as myfile:
		listOfStrings = myfile.readlines()

	# print (listOfStrings)

	listOfPotentialNumbers = [] # Blank list of possible codes
	for oneString in listOfStrings: # Each line of the text file
		tempStr = oneString.strip("\n") # Removes \n
		tempSpaceList = tempStr.split(" ") # List of words in each line
		numOnlyWordList = []
		for elem in tempSpaceList: # Word in list
			numOnlyStr = ""
			for eachChar in elem:
				if eachChar.isdigit():
					numOnlyStr = numOnlyStr + eachChar
			numOnlyWordList.append(numOnlyStr)
		#print(numOnlyWordList)

		# Removes all alphabets and converts the file to a num only mode

		for elem in numOnlyWordList:
			if ((len(elem) == 10)): # Taking the number of digits to be between 10 and 12
				listOfPotentialNumbers.append(elem)

	print(listOfPotentialNumbers)

	listOfItemsBought = []
	yahoo = "https://sheetsu.com/apis/469cfd79"
	getRequest = requests.get(yahoo)
	parsed_json = json.loads(getRequest.text)

	listofDict = parsed_json["result"]

	for elem in listOfPotentialNumbers:
		for eleminDict in listofDict:
			if elem = eleminDict["upc"]:
				listOfItemsBought.append(eleminDict["productname"])

    return listOfItemsBought

if __name__ == '__main__':
    app.run()
