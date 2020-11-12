import 'dart:io';
import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                child: Image.asset('images/women1.png'),
                height: 120.0,
              ),

              Container(
                child: Image.asset('images/women.png'),
                height: 170.0,
              ),

            ],
          )

        ],
      ),
      backgroundColor: Hexcolor('#FFFED8'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(

              children: <Widget>[
                SizedBox(
                  height: 120.0,
                ),
                Text(
                  'CONNECTOR PH',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'Architects',
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                const Divider(
                  color: Colors.black,
                  height: 10.0,
                  thickness: 2.5,
                  indent: 0,
                  endIndent: 0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'FIND DETAILS OF HOSPITAL NEARBY ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 10.0,
                    letterSpacing: 3.5,
                  ),
                ),
                Text(
                  'INSTANTLY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 3.5,
                    fontSize: 10.0,

                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Material(
                elevation: 5.0,
                color: Hexcolor('#FFFA48'),
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  minWidth: 500.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontFamily: 'Architects',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Container(
                child: Text(
                  'WEAR MASK AND PROTECT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 3.5,
                    fontSize: 10.0,
                ),
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Container(
                child: Text(
                  'YOURSELF AND OTHERS !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'ZillaSlab',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 3.5,
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
