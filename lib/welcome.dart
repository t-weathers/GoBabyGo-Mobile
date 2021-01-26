import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Welcome extends StatefulWidget {
  Welcome({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WelcomeState createState() => _WelcomeState();
}

//first page on login

class _WelcomeState extends State<Welcome> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.orange[800],
      fontSize: 20.0,
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final String _parent = "TestParent";
    final String _kiddo = "TestKiddo";
    final welcomeText = Text(
      'Hello, $_parent and $_kiddo! Welcome to the GoBabyGo App',
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: style,
    );
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange[800], Colors.white])),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200.0,
                  child: Image.asset(
                    "assets/GoBabyGo_WEBLOGO.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 80.0,
                  width: 200,
                ),
                welcomeText,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
