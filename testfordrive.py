import gspread
from oauth2client.service_account import ServiceAccountCredentials

def write(info):
    scope = ["https://spreadsheets.google.com/feeds",'https://www.googleapis.com/auth/spreadsheets',"https://www.googleapis.com/auth/drive.file","https://www.googleapis.com/auth/drive"]

    creds=ServiceAccountCredentials.from_json_keyfile_name("creds.json",scope)

    client=gspread.authorize(creds)
    sheet=client.open('pvg').sheet1
    data=sheet.get_all_records()
    insertRow=[info['date'] , info['time'] , info['car number'],info['access'] ]
    #sheet.resize(1)
    sheet.append_row(insertRow)

#pprint(data)