import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectorph/screens/welcome_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  var Userdistrict;
  var UserMail;
  var name;
  var address;
  var district;
  var tbeds;
  var cost;
  var beds;
  var url1, url2, url3, url4;
  var icu;
  var ph;
  var ticu;
  var time,desc;
  bool spinner = true;
  final _auth = FirebaseAuth.instance;

  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //getLocation();
    setState(() {
      reassemble();
    });
  }
  var temp,mail;
  @override
  Future getDetails() async{
    final user = await _auth.currentUser;
    final msg = await _firestoreInstance.collection('Hospitals').where('Email', isEqualTo: '$UserMail').get();
    for(var m in msg.docs)
    {
      temp=m.data();
    }
    mail = temp['Email'];
    name = temp['Name'];
    address = temp['Address-Text'];
    beds = temp['Beds'];
    tbeds = temp['Total Beds'];
    icu = temp['Icu'];
    district = temp['District'];
    ph = temp['Contact'];
    cost = temp['Cost'];
    ticu = temp['Total Icu'];
    time = temp['Timings'];
    url1 = temp['Img1'];
    url2 = temp['Img2'];
    url3 = temp['Img3'];
    url4 = temp['Img4'];
    desc = temp['Description'];
    setState(() {});
  }
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        UserMail = user.email;
        final uid=user.uid;
      }
      print(UserMail);
    } catch (e) {
      print(e);
    }
    //setState(() {});
  }
  Widget build(BuildContext context) {
    spinner = false;
    getDetails();
    setState(() {
      reassemble();
    });
    return Scaffold(
        backgroundColor: Hexcolor('#eff48e'),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()));
              }),
        ],
        title: Text(
          'Connector_PH',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Architects',
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Hexcolor('#d2e603'),
      ),
      body: ListView(
        children: [
          Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('$url1'),
              radius: 50.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '$name',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  fontFamily: 'ZillaSlab',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '$mail',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                  letterSpacing: 2.5,
                  fontFamily: 'ZillaSlab',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 50.0,
              width: 270.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color: Colors.black12,
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                title: Text('$ph',
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color: Colors.black12,
              child: ListTile(
                leading: Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                title: Text('$time',
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color: Colors.black12,
              child: ListTile(
                leading: Icon(
                  Icons.business,
                  color: Colors.black,
                ),
                title: Text('$address',
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              color: Colors.black12,
              child: ListTile(
                leading: Icon(
                  Icons.place,
                  color: Colors.black,
                ),
                title: Text('$district',
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
              width: 270.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    letterSpacing: 2.5,
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '     $desc',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontFamily: 'ZillaSlab',
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        ],
      ),
    );
  }
}