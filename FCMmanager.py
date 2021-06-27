import firebase_admin
from firebase_admin import credentials,messaging


cred = credentials.Certificate("C:\\Users\\sohil\\Documents\\SDL\\firstproject-3d559-firebase-adminsdk-ou62n-57eaa03fba.json")
firebase_admin.initialize_app(cred)
registration_token='dKFwrM_PSQaqc62TZrHNMt:APA91bHDpqNR_ZxMPoSEL7zKVO5qnZuN212DirhbMI3drb8BFAFK3HbPgPT5Ad2Mivc5luhF_eP0cMxYLDC_4zGC7rC2ygIqMEBymbWvBwmAmNjixK8a3NWHn5b3RAcjPcPT-fPr1rAU'
def send_to_token(carnum):
    # [START send_to_token]
    # This registration token comes from the client FCM SDKs.
    #registration_token='fkxMKAjCR-eOiPlhoHv9rY:APA91bHLu4rQgOzuTELdOslqHCDHfHqncHl3qOZsWQcYxeltTJCblfnZbbEKHP5AwVWD2bSgJL3zGYqkQWZjq_z39Nq_jGyHkxU8kWSIBEd-1-DW0131p63tTnCtegrNtx0j-TnckOVZ'
    #registration_token='fCf8CUEiTSGczsHkJb_Xc8:APA91bHPq_KPdE1snZWOag23wWNZ6AjCx4zikbOuXq2PgCphLaYINtMz9N6sPkWrXn2aSNZqquTAJkDbg_wllzRAd7i1n7iWDcuXN7AuwrEK10C4LKRfqOfN6TEEGIV4FXKeSI9V6rpk'
    # See documentation on defining a message payload.
    #mi phone registration_token='e0KdYaRjRbqGQ9l26q8JhL:APA91bFc0OPXt3yJVu1OAyggccJ3liRbbycTTwajJiLlu7eSVeg0tTWfkoK3I96HVp-bVkFlhOoCkSwPdHshDwPCHxRV44Z0WkeIj3oHN-AKMrweB7shiM3L4yNeqDL5CADlfS2482Qv'
    message = messaging.Message(
        notification=messaging.Notification(
           title='New Vehicle is arrived', 
            body=carnum
        ),
        token=registration_token,
    )
    #print('ads')
    # Send a message to the device corresponding to the provided
    # registration token.
    response = messaging.send(message)
    # Response is a message ID string.
    print('Successfully sent message:', response)
    # [END send_to_token]'''

'''def sendPush(title,msg,registration_token,dataObject=None):
    message=messaging.MulticastMessage(
        notification=messaging.Notification(
            title=title,
            body=msg
        ),
        data=dataObject,
        token=registration_token
    )
    response=messaging.send_multicast(message)
    print('Successfully sent message : ',response)'''
