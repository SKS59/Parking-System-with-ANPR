//import 'package:firebase/firebase.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
var alldata;
void main() => runApp(MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
    ));

class MainPage extends StatefulWidget {
  MyApp createState() => MyApp();
}

class MyApp extends State<MainPage> {
  //Your code here
  String afteradd = 'ADDED SUCCESSFULLY';
  String aftervisitor = 'ADDED AS VISITOR SUCCESSFULLY';
  String afterdeny = 'DENIED SUCCESSFULLY';
  String carnumber = '';
  String greetings2 = '';
  String name = '';
  String finalres = '';
  int index = 1;
  var all;
  final databaseReference = FirebaseDatabase.instance.reference();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.getToken().then((token) {
      print(token);
    });
  }

  /*_launchURL() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1Ok0jsnP-svpaV4US-Haif89_c_ncIJ3IhXsqJYHhTSY/edit?usp=sharing';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Parking Vigilance System'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body:
            /*Container(
        Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[Text(
            '$carnumber',
            style: TextStyle(fontSize: 30.0),
          )
          ] 
        ),
        ),*/
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  getData();
                  print('getting number');
                },
                child: Row(children:<Widget>[Icon(Icons.confirmation_number),Text('GET NUMBER')]),
                color: Colors.blue,
                splashColor: Colors.cyanAccent,
                padding: EdgeInsets.all(0),
              ),
              RaisedButton(
                onPressed: () {
                  launch(
                      'https://docs.google.com/spreadsheets/d/1Ok0jsnP-svpaV4US-Haif89_c_ncIJ3IhXsqJYHhTSY/edit?usp=sharing');
                },
                /*_launchURL()*/
                child: Row(
                    children: <Widget>[Icon(Icons.list), Text('All ENTRIES')]),
                color: Colors.blue,
                splashColor: Colors.cyanAccent,
              ),
              RaisedButton(
                onPressed: () {
                  launch(
                      'https://firebasestorage.googleapis.com/v0/b/firstproject-3d559.appspot.com/o/images%2Ffoo.jpg?alt=media');
                },
                /*_launchURL()*/
                child: Row(
                    children: <Widget>[Icon(Icons.image), Text(' GET IMAGE')]),
                color: Colors.blue,
                splashColor: Colors.blue,
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 220)),
          Text(
            '$carnumber',
            style: TextStyle(fontSize: 45.0),
          ),
          Padding(padding: EdgeInsets.only(bottom: 280)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  createRecord();
                  setState(() {
                    greetings2 = afteradd;
                    carnumber = '';
                  });
                },
                color: Colors.green,
                child: Row(children: <Widget>[Icon(Icons.add), Text('ADD')]),
                splashColor: Colors.cyanAccent,
              ),
              RaisedButton(
                onPressed: () {
                  getVisitor();
                  setState(() {
                    greetings2 = aftervisitor;
                    carnumber = '';
                  });
                },
                color: Colors.amber,
                child: Text('ALLOW AS VISITOR'),
                splashColor: Colors.cyanAccent,
              ),
              FlatButton(
                onPressed: () async {
                  getDeny();
                  setState(() {
                    greetings2 = afterdeny;
                    carnumber = '';
                  });
                },
                color: Colors.deepOrange,
                child: Row(children: <Widget>[Icon(Icons.error), Text('DENY')]),
                splashColor: Colors.cyanAccent,
              )
            ],
          ),
          Icon(Icons.car_repair),
          Text('$greetings2'),
        ]));
  }

  void createRecord() {
    final databasereference =
        FirebaseDatabase.instance.reference().child('car number');
    String uploadID = databasereference.push().key;
    //HashMap map=new HashMap();
    databasereference.child(uploadID).set(carnumber);
    databaseReference.child('responsefromflut').set({'response': 'add'});
  }

  void getVisitor() {
    final databasereference =
        FirebaseDatabase.instance.reference().child('visitor');
    String uploadID = databasereference.push().key;
    databasereference.child(uploadID).set(carnumber);
    databaseReference.child('responsefromflut').set({'response': 'visitor'});
  }

  void getData() async {
    databaseReference
        .child("current")
        .child("curr_vehicle")
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        carnumber = snapshot.value;
      });
      print(carnumber.toString());
    });

    //StorageUploadTask uploadTask = ref.putFile(imageFile);
    //print(refobj);
    //url = dowurl.toString();
  }

  void getDeny() {
    setState(() {
      carnumber = '';
    });
    print(carnumber);
    databaseReference.child('responsefromflut').set({'response': 'deny'});
  }

  void getAll() {
    databaseReference.child("all entries").once().then((DataSnapshot snapshot) {
      setState(() {
        alldata = snapshot.value;
      });
      print(alldata);
    });
  }
}
//class SecondPage extends StatefulWidget {
//SecondRoute createState() => SecondRoute();
//}

class SecondRoute extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("All Enties"),
        ),
        body: Center());
  }
}
/*class MyApp extends StatelessWidget {
  String addtemp = 'ADDED SUCCESSFULLY';
  //void changestate() {
  //setState(() {
  //addtemp = 'ADDED SUCCESSFULLY';
  //});
  //}
  String greetings = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Parking Vigilance System'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        //backgroundColor: Colors.white70,
        body:
            Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Text(greetings),
          //style: TextStyle(fontSize: 24.0),
          //),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  final response =
                      await http.get('http://192.168.43.233:5000/');
                  final decoded =
                      jsonDecode(response.body) as Map<String, dynamic>;
                  setState(() {
                    greetings = decoded['greetings'];
                  });
                },
                color: Colors.blue,
                child: Text('ADD'),
                splashColor: Colors.cyanAccent,
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.amber,
                child: Text('ALLOW AS VISITOR'),
                splashColor: Colors.cyanAccent,
              ),
              FlatButton(
                onPressed: () {},
                color: Colors.deepOrange,
                child: Text('DENY'),
                splashColor: Colors.cyanAccent,
              )
            ],
          ),
          Icon(Icons.car_repair),
        ]));
  }
}
*/
