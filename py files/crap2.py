from PIL import Image
import commands
usrimg = Image.open("/Users/himankyadav/Desktop/hackIllinois-fresheries/test1.jpg")
# Converting the image to greyscale.
captcha = usrimg.convert('1')                               
# Saving the image as tesseract can read.
captcha.save('temp.bmp', dpi=(200,200))
# Invoking tesseract from python to extract characters
commands.getoutput('tesseract temp.bmp data')
# Reading the output generated in data.txt
with open('data.txt', 'r') as data:
    print data.readline().strip()