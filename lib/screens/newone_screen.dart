import 'dart:io';
import 'dart:ui';
import 'dart:wasm';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectorph/screens/welcome_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
class NewScreen extends StatefulWidget {
  const NewScreen({Key key}) : super(key: key);
  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen>{
  bool spinner = true;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  File img1,img2,img3,img4;
  var img1url,img2url,img3url,img4url;
  @override
  void initState(){
    super.initState();
    getCurrentUser();
  }
  var UserMail,name,address,district,tbeds,beds,icu,desc,ticu,ph,cost,id,time,lat,lon;
  num la,lo;
  double la1,lo1;
  Future getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        UserMail = user.email;
        final uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
  }
  Future chooseFile1() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        img1 = image;
      });
    });
  }
  Future uploadFile1() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('1$UserMail');
    StorageUploadTask uploadTask = storageReference.putFile(img1);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        img1url = fileURL;
      });
    });
  }
  Future chooseFile2() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        img2 = image;
      });
    });
  }
  Future uploadFile2() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('2$UserMail');
    StorageUploadTask uploadTask = storageReference.putFile(img2);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        img2url = fileURL;
      });
    });
  }
  Future chooseFile3() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        img3 = image;
      });
    });
  }
  Future uploadFile3() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('3$UserMail');
    StorageUploadTask uploadTask = storageReference.putFile(img3);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        img3url = fileURL;
      });
    });
  }
  Future chooseFile4() async {
    // ignore: deprecated_member_use
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        img4 = image;
      });
    });
  }
  Future uploadFile4() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('4$UserMail');
    StorageUploadTask uploadTask = storageReference.putFile(img4);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        img4url = fileURL;
      });
    });
  }
  //var pass;
  /*Future<Null> _changePassword(String newPassword) async {
    //ignore: deprecated_member_use
   // FirebaseUser user = await await _auth.currentUser;
    const String API_KEY = 'AIzaSyAR3AvtcpbHCIteksK-OQgeCHuibz3EW1g';
    final String changePasswordUrl =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/setAccountInfo?key=$API_KEY';

    final String idToken = UserMail;//await user.getIdToken(); // where user is FirebaseUser user

    final Map<String, dynamic> payload = {
      'email': idToken,
      'password': newPassword,
      'returnSecureToken': true
    };

    await http.post(changePasswordUrl,
      body: json.encode(payload),
      headers: {'Content-Type': 'application/json'},
    );
  }*/
  @override
  Widget build(BuildContext context) {
    spinner =false;
    return Scaffold(
      backgroundColor: Hexcolor('#FFFED8'),
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
                    keyboardType: TextInputType.visiblePassword,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      name=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Hospital Name',
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
                  ),//hospital name
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.datetime,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      time=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Timings',
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
                  ),//time
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
                  ),//total beds
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      beds=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Available Beds',
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
                  ),//beds
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      ticu=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Total ICUs',
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
                  ),//total icu
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      icu=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'ICU',
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
                  ),//icu
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      cost=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Avg Treatment Cost',
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
                  ),//cost
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      lat=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Latitude',
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
                  ),//geopoint
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      lon=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Longitude',
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
                  ),//geopoint
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
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
                  ),//address
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      district=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'District',
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
                  ),//district
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.name,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      ph=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Contact',
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
                  ),//contact
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    cursorColor: Colors.black,
                    style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                    onChanged: (value) {
                      //Do something with the user input.
                      desc=value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                  Text(
                    'IMAGES',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.center,
                  ),//images
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Hospital(Front)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  img1 != null
                      ? Image.asset(
                    img1.path,
                    height: 150,
                  )
                      : Container(
                    height: 50.0,
                    child: Icon(Icons.image,
                      color: Colors.black,
                    ),
                  ),
                  img1 == null
                      ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile1,
                    color: Colors.cyan,
                  )
                      : Container(),
                  img1 != null
                      ? RaisedButton(
                    child: Icon(Icons.file_upload,
                    ),
                    onPressed: uploadFile1,
                    color: Colors.cyan,
                  )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Treatment Beds',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  img2 != null
                      ? Image.asset(
                    img2.path,
                    height: 150,
                  )
                      : Container(
                    height: 50.0,
                    child: Icon(Icons.image,
                      color: Colors.black,
                    ),
                  ),
                  img2 == null
                      ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile2,
                    color: Colors.cyan,
                  )
                      : Container(),
                  img2 != null
                      ? RaisedButton(
                    child: Icon(Icons.file_upload,
                    ),
                    onPressed: uploadFile2,
                    color: Colors.cyan,
                  )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'ICU',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  img3 != null
                      ? Image.asset(
                    img3.path,
                    height: 150,
                  )
                      : Container(
                    height: 50.0,
                    child: Icon(Icons.image,
                      color: Colors.black,
                    ),
                  ),
                  img3 == null
                      ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile3,
                    color: Colors.cyan,
                  )
                      : Container(),
                  img3 != null
                      ? RaisedButton(
                    child: Icon(Icons.file_upload,
                    ),
                    onPressed: uploadFile3,
                    color: Colors.cyan,
                  )
                      : Container(),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Waiting Hall',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  img4 != null
                      ? Image.asset(
                    img4.path,
                    height: 150,
                  )
                      : Container(
                    height: 50.0,
                    child: Icon(Icons.image,
                      color: Colors.black,
                    ),
                  ),
                  img4 == null
                      ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile4,
                    color: Colors.cyan,
                  )
                      : Container(),
                  img4 != null
                      ? RaisedButton(
                    child: Icon(Icons.file_upload,
                    ),
                    onPressed: uploadFile4,
                    color: Colors.cyan,
                  )
                      : Container(),
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
                          //_changePassword('$pass');
                          final user = await _auth.currentUser;
                          // ignore: deprecated_member_use
                          _firestoreInstance.collection('Hospitals').document('$UserMail').setData({
                            'Email' : UserMail,
                            'Name' : name,
                            'Address-Text' : address,
                            'Lat' : lat,
                            'Long' : lon,
                            'Cost' : cost,
                            'District' : district,
                            'Total Beds' : tbeds,
                            'Timings' : time,
                            'Beds' : beds,
                            'Icu' : icu,
                            'Total Icu' : ticu,
                            'Contact' : ph,
                            'Ratings' : '0',
                            'Description' : desc,
                            'Img1' : img1url,
                            'Img2' : img2url,
                            'Img3' : img3url,
                            'Img4' : img4url,
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
                  ),//submit button
                ],
              ),
            ),
            ],
          ),
      ),
    );
  }
}
