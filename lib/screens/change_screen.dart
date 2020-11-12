import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectorph/screens/welcome_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChangeScreen extends StatefulWidget{
  @override
  _ChangeScreenState createState() => _ChangeScreenState();
}
class _ChangeScreenState extends State<ChangeScreen> {
  bool spinner = true;
  var Userdistrict;
  var UserMail;
  var name;
  var address;
  var district;
  var tbeds;
  var cost;
  var beds;
  var icu;
  var ph;
  var ticu;
  var time;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getDetails();
  }
  var temp;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  @override
  Future getDetails() async{
    final user = await _auth.currentUser;
    final msg = await _firestoreInstance.collection('Hospitals').where('Email', isEqualTo: '$UserMail').get();
    for(var m in msg.docs)
    {
      temp=m.data();
    }
    name = temp['Name'];
    address = temp['Address'];
    beds = temp['Beds'];
    tbeds = temp['Total Beds'];
    icu = temp['Icu'];
    district = temp['District'];
    ph = temp['Contact'];
    cost = temp['Cost'];
    ticu = temp['Total Icu'];
    time = temp['Timings'];
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
  }
  Future<Null> _refresh() {
    return getCurrentUser().then((_user) {
      setState(() => UserMail = _user);
    });
  }
  @override
  Widget build(BuildContext context) {
    //getCurrentUser();
    spinner = false;
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
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: ListView(
          children:[
            SizedBox(
              height: 25.0,
            ),
            Text(
              'CHANGE DETAILS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontFamily: 'ZillaSlab',
                fontWeight: FontWeight.w600,
                letterSpacing: 3.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding:EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      address=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle( color: Colors.black,fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Hexcolor('#FFFF01'), width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      district=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'District',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      tbeds=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Total Beds',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      ticu=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Total ICUs',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      ph=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      cost=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Cost',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.datetime,
                    //obscureText: _showPassword,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      time=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Timings',
                      labelStyle: TextStyle(color: Colors.black, fontFamily: 'Architects'),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01') , width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color:Hexcolor('#FFFF01'), width: 4.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Hexcolor('#FFFA48'),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(

                        onPressed: () async {
                          setState(() {
                            spinner=true;
                          });
                          final user = await _auth.currentUser;
                          // ignore: deprecated_member_use
                          _firestoreInstance.collection("Hospitals").document('$UserMail').updateData({
                            "Total Beds" : tbeds,
                            'Total Icu' : ticu,
                            'Address-Text' : address,
                            'Cost' : cost,
                            'District' : district,
                            'Contact' : ph,
                            'Timings' : time,
                          });
                          Navigator.pushNamed(context, 'home');
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: Text(
                          'Submit',style: TextStyle(
                          fontFamily: 'Architects',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}