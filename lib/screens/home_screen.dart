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
import 'package:carousel_slider/carousel_slider.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  var Userdistrict;
  var UserMail;
  var name;
  var address;
  var district;
  var tbeds;
  var cost;
  var beds;
  var url1,url2,url3,url4;
  var icu;
  var ph;
  var ticu;
  var time;
  bool spinner = true;
  final _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  final _firestoreInstance = Firestore.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    //getLocation();
    isNew();
    setState(() {
      reassemble();
    });
  }
  var mail;
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
  Future<Null> _refresh() {
    return getCurrentUser().then((_user) {
      setState(() => UserMail = _user);
    });
  }
 var a=0;
 void isNew() async{
   final user = await _auth.currentUser;
   final msg= await _firestoreInstance.collection('Hospitals').get();
   for(var m in msg.docs)
     {
       if(m.data().containsValue("$UserMail")){
         //print(m.data());
         a=1;
         //a=m.data();
       }

     }
   if(a==0){
     Navigator.pushNamed(context, 'newone');
   }
   //print(a.data["email"]);
 }
  @override
  Widget build(BuildContext context) {

   spinner=false;
    setState(() {
      reassemble();
    });
   getDetails();
    return Scaffold(
        backgroundColor: Hexcolor('#eff48e'),
      bottomNavigationBar: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 5.0,
                  color: Hexcolor('#FFFA48'),
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'update');
                    },
                    minWidth: 300.0,
                    height: 42.0,

                    child: Text(
                      'UPDATE AVAILABILITY',
                      style: TextStyle(
                        fontFamily: 'Architects',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        drawer: Drawer(
          elevation: 20.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                ),
                  child: Text(
                    "$name \n $mail",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'ZillaSlab',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ),

              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
                onTap: (){
                  //do something
                  Navigator.pushNamed(context, 'profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.add_to_queue),
                title: Text('Update Details'),
                onTap: (){
                  //do spmething
                  Navigator.pushNamed(context, 'change');
                },
              ),
              /*ListTile(
                leading: Icon(Icons.assessment),
                title: Text('SCAN'),
                onTap: (){
                  //do spmething
                  //Navigator.pushNamed(context, 'scan');
                },
              ),*/
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Change Password'),
                onTap: (){
                  // do something
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('About Us'),
                onTap: (){
                  // do something
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout'),
                  onTap: () {
                    _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  }
              ),
            ],
          ),
        ),
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
        body: RefreshIndicator(

          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: ModalProgressHUD(
            inAsyncCall: spinner,
            child: ListView(
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 250.0,
                        viewportFraction: 1,
                        initialPage: 0,
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.easeInOutBack),
                    items: [
                      GestureDetector(
                        onTap: ()=>second1(context),
                        child: Hero(
                          tag: 'hiyo',
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage('$url1'),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>second2(context),
                        child: Hero(
                          tag: 'heya',
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage('$url2'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>second3(context),
                        child: Hero(
                          tag: 'hoya',
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage('$url3'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()=>second4(context),
                        child: Hero(
                          tag: 'hiya',
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: NetworkImage('$url4'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 5.0,
                  ),

                  SizedBox(
                    height: 5.0,
                  ),

                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Divider(
                      color: Colors.black45,
                      height: 10.0,
                      thickness: 2.0,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Text(
                      'AVAILABILITY',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'ZillaSlab',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    textAlign: TextAlign.center,
                    ), //Availablity
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
                              Text(
                                'Treatment Beds',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '$beds',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 60.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Available',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'ICU',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 3.5
                                ),
                              ),
                              Text(
                                '$icu',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 60.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                'Available',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                    ],
                  ),//first row of availability
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Divider(
                      color: Colors.black45,
                      height: 10.0,
                      thickness: 2.0,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Text(
                    'TOTAL',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontFamily: 'ZillaSlab',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.5,
                    ),
                    textAlign: TextAlign.center,
                  ),//total
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
                              Text(
                                'Treatment Beds',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                  fontFamily: 'ZillaSlab',
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                '$tbeds',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 75.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w700),
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
                      Expanded(
                        child: Container(
                          width: 150.0,
                          height: 150.0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                'ICU',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 3.5
                                ),
                              ),
                              Text(
                                '$ticu',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 75.0,
                                    fontFamily: 'ZillaSlab',
                                    fontWeight: FontWeight.w700),
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
                  ),//second row of total
                  SizedBox(
                    height: 10.0,
                  ),
                ]),
          ),
        ),
    );
  }
  void second1(BuildContext context){
   Navigator.of(context).push(
    MaterialPageRoute(
        builder: (ctx) => Scaffold(
          body: Center(
            child: Hero(
              tag: 'hiyo',
              child: Image.network('$url1'),
            ),
          ),
        )
    ) 
   );
  }
  void second2(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Hero(
                  tag: 'heya',
                  child: Image.network('$url2'),
                ),
              ),
            )
        )
    );
  }
  void second3(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Hero(
                  tag: 'hoya',
                  child: Image.network('$url3'),
                ),
              ),
            )
        )
    );
  }
  void second4(BuildContext context){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => Scaffold(
              body: Center(
                child: Hero(
                  tag: 'hiya',
                  child: Image.network('$url4'),
                ),
              ),
            )
        )
    );
  }
}
