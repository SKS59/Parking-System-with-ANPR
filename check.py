import pyrebase
import numplate
from datetime import datetime
import time as t
import os
import json
#from firebase_admin import messaging
#from firebase import firebase
from firebase_admin import messaging
import firebase_admin
from firebase_admin import credentials
import FCMmanager as fcm
import testfordrive as td
tokens='dKFwrM_PSQaqc62TZrHNMt:APA91bHDpqNR_ZxMPoSEL7zKVO5qnZuN212DirhbMI3drb8BFAFK3HbPgPT5Ad2Mivc5luhF_eP0cMxYLDC_4zGC7rC2ygIqMEBymbWvBwmAmNjixK8a3NWHn5b3RAcjPcPT-fPr1rAU'
config = {
	'apiKey': "AIzaSyCD5i1oePwFIqcKEXcVONK3tusRffAmhrY",
    'authDomain': "firstproject-3d559.firebaseapp.com",
    'databaseURL': "https://firstproject-3d559.firebaseio.com",
    'projectId': "firstproject-3d559",
    'storageBucket': "firstproject-3d559.appspot.com",
    'messagingSenderId': "98858095882",
    'appId': "1:98858095882:web:6583a2515e1da7330d56f3",
    'measurementId': "G-QZ575N25CF"
}

#https://firebasestorage.googleapis.com/v0/b/firstproject-3d559.appspot.com/o/images%2Ffoo.jpg?alt=media

timedate=str(datetime.now().strftime('%Y-%m-%d %H:%M:%S'))
date=timedate.split()[0]
time=timedate.split()[1]

carnum=numplate.ANPR.detectNumberPlate('images/b0.jpg')

fb1=pyrebase.initialize_app(config)
fb=fb1.database()
fb_storage=fb1.storage()
#carnum='MH19CD5457'
info={
	'date':date,
	'time':time,
	'car number':carnum
}
#fb.child('car number').push(carnum)

data=fb.child('car number').get().val().values()
#print(data)

path_on_cloud='images/foo.jpg'
path_loacal='foo.jpg'
fb_storage.child(path_on_cloud).put(path_loacal)
if carnum not in data:
	
	fb.child('current').set({'curr_vehicle':info['car number']})
	# CODE TO BE ADDED TO SEND NOTIFICATION TO FLUTTER
	fcm.send_to_token(carnum)
	print('notification sent')
	t.sleep(25)
	response=fb.child('responsefromflut').get().val().values()
	for i in response:
		print(response)	
		if i=='add':
			print('ADDED')
			info['access']='allowed'
			os.system('allowed.wav')
		elif i=='deny':
			print('denying')
			info['access']='denied'
			os.system('denied.wav')
		elif i=='visitor':
			print('visitor')
			info['access']='allowed as visitor'
			os.system('visitor.wav')
		elif i=='NULL':
			print('NULL')
			info['access']='denied'
			os.system('noresponse.wav')

else:
	info['access']='allowed'
	os.system('allowed.wav')


fb.child('all entries').push(info)
td.write(info)
fb.child('responsefromflut').set({'response':'NULL'})