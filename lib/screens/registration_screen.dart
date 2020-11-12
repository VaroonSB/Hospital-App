import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool spinner = false;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Hexcolor('#FFFED8'),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('Follow Social Distance ',style: TextStyle(
                fontFamily: 'ZillaSlab',
                fontSize: 50.0,
              ),),

              SizedBox(
                height: 25.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle( color: Colors.black,fontFamily: 'Architects'),
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
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black,fontFamily: 'Architects'),
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your password.',
                  hintStyle: TextStyle( color: Colors.black,fontFamily: 'Architects'),
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
                height: 24.0,
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
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if(newUser!= null){
                        Navigator.pushNamed(context, 'chat');
                      }
                      setState(() {
                        spinner=false;
                      });
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Register',style: TextStyle(
                      fontFamily: 'Architects',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  child: Text("Already have an account", style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: 'Architects',
                      fontSize: 20.0,
                      color: Colors.blue),textAlign: TextAlign.center,),
                  onTap: () {
                    print(email);
                    Navigator.pushNamed(context, 'login');
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
