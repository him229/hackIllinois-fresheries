# from pytesseract import image_to_string
# from PIL import Image

# im = Image.open(r'/Users/himankyadav/Desktop/hackillinois-fresheries/test1.jpg')
# print(im)

# with open("testOutput.txt", "w") as myfile:
# 	myfile.write(image_to_string(im))

import requests
import json
API_KEY = "50732aac0d96a678b460b22c6eb07225"
constantListOfItems = ["vinegar", "sugar", "tobasco", "sauce", "foldgers", "baking soda", "oil", "spaghetti", "drink", "dressing", "brow", "cheese", "macaroni", "cake", "chick", "progresso", "barly"]

#Take care of receipt 1
#Receipt 2
	# INST BRKFST = breakfast
	# brownie = brow
	# cake mix = cake
	# chick = frozen chicken meal
	# barly = soup
# Receipt 3


with open("Output2.txt", "r") as myfile:
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


# TO DO
	# take into consideration bad request
listOfItemsBought = []
for elem in listOfPotentialNumbers:
	#yahoo = "http://api.upcdatabase.org/json/" + API_KEY + "/"+elem
	yahoo = "http://www.searchupc.com/handlers/upcsearch.ashx?request_type=3&access_token=97B5D527-F73C-47DB-A4AD-3D23C90D6B34&upc="+elem
	getRequest = requests.get(yahoo)
	parsed_json = json.loads(getRequest.text)
	#print(getRequest.json())

	for k,v in parsed_json.iteritems():
		print(v['productname'])

	# if parsed_json["valid"] == "true":
	# 	print("DESCRIPTION" + parsed_json["description"])
	# 	print("NAME" + parsed_json["itemname"])
	# else:
	# 	print ("fail")

	# if parsed_json["valid"] == "true":
	# 	if (parsed_json["itemname"] == ""):
	# 		print(parsed_json["description"])
	# 	else:
	# 		print(parsed_json["itemname"])
	# else:
	# 	print("Item is crappy. NOT FOUND.")


# 	if parsed_json["valid"] == "true":
# 		if (parsed_json["itemname"] == ""):
# 			description = parsed_json["description"]
# 			print(description)
# 			descriptionList = description.split()
# 			for elem in descriptionList:
# 				for elem2 in constantListOfItems:
# 					if elem == elem2:
# 						listOfItemsBought.append(elem2)
# 		else:
# 			name = parsed_json["itemname"]
# 			print(name)
# 			nameList = name.split()
# 			for elem in name:
# 				for elem2 in constantListOfItems:
# 					if elem==elem2:
# 						listOfItemsBought.append(elem2)
# 	else:
# 		print("Item is crappy. NOT FOUND.")
# print(listOfItemsBought)
