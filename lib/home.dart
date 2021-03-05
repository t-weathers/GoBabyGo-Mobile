import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/activities.dart';
import 'package:testing_app/faq.dart';
import 'package:testing_app/profile.dart';
import 'package:testing_app/timelog.dart';
import 'package:testing_app/forum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'my_flutter_app_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';



//From get data from internet



//first home page on login

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.gsi}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
  //_MyTimeLogPageState.createState() => _MyyTimeLogPageState();
}

//first page on login
//class _MyTimeLogPageState extends State<MyHomePage> {



class _MyHomePageState extends State<MyHomePage> {
  //final GoogleSignIn googleSI;


  //@override
  //_MyHomePageState({Key key, @required this.googleSI}) : super(key: key);
  //String googleSignIn;
  GoogleSignInAccount googleSignIn;
  void initState(){
    googleSignIn = widget.gsi;
    super.initState();
  }

  TextStyle style =
  TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20.0);
  TextStyle style1 =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 36.0);
  TextStyle connectStyle =
  TextStyle(fontFamily: 'Montserrat', color: Colors.black, fontSize: 16);

  int _currentIndex = 0;


  void onTappedBar(int index){
    setState((){
      _currentIndex = index;
    });


    }
  Widget getPage(int ind){
    switch (ind){
      case 0:
        return profile(gsi: googleSignIn);
        break;
      case 1:
        return timelog(gsi: googleSignIn);
        break;
      case 2:
        return activities();
        break;
      case 3:
        return faq();
        break;
    }
/*    if (_currentIndex == 0){
      Navigator.push(context, MaterialPageRoute(builder: (context) => profile()));
    }
    if (_currentIndex == 1){
      Navigator.push(context, MaterialPageRoute(builder: (context) => timelog(gsi: googleSignIn)));
    }
    if (_currentIndex == 2){
      Navigator.push(context, MaterialPageRoute(builder: (context) => activities()));

    }
    if (_currentIndex == 3){
      Navigator.push(context, MaterialPageRoute(builder: (context) => faq()));
    }*/
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
     // appBar: AppBar(
       // title: Text('Profile'),
        //backgroundColor: Colors.grey,
        //centerTitle: true,
      //),

      body: getPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Colors.grey,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(MyFlutterApp.user),
            label: "Profile",
           // backgroundColor: Colors.orange[900],
            backgroundColor: Colors.grey[350],
            // backgroundColor: Colors.grey[600],
            //label: 'Profile',
           /// icon: Icon(MyFlutterApp.user),
          //  icon: IconButton({
           //   icon: Icon(MyFlutterApp.user),
             // onPressed: NULL,
            //}),
    ),
  //  BottomNavigationBarItem(
  //  label:'Forum',
  //  icon: Icon(MyFlutterApp.chat),

   // ),
    BottomNavigationBarItem(
    label:'Time Log',
    icon: Icon(MyFlutterApp.future),
      //backgroundColor: Colors.orange[900],
      backgroundColor: Colors.grey[350],
      // backgroundColor: Colors.grey[600],
    ),
    BottomNavigationBarItem(
    label: 'Activities',
    icon: Icon(MyFlutterApp.steering_wheel),
     // backgroundColor: Colors.orange[900],
      backgroundColor: Colors.grey[350],
      // backgroundColor: Colors.grey[600],
    ),
    BottomNavigationBarItem(
    label: 'FAQ',
    icon: Icon(MyFlutterApp.information),
     // backgroundColor: Colors.orange[900],
      backgroundColor: Colors.grey[350],
     // backgroundColor: Colors.grey[600],
    ),



    ],
    selectedItemColor: Colors.orange[900],



    ),
    );
    }
  }
