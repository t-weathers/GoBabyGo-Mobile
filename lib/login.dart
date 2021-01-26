import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/home.dart';
import 'package:testing_app/welcome.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

//first page on login

class _LoginState extends State<Login> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20.0);

  final passwordstring = TextEditingController();
  final emailstring = TextEditingController();

  clearTextInput() {
    passwordstring.clear();
    emailstring.clear();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
        controller: emailstring,
        obscureText: true,
        style: style,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
    final passwordField = TextField(
        controller: passwordstring,
        obscureText: true,
        style: style,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ));
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.orange[900],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //THIS IS WHERE THE BUTTON CLICK GOES
        onPressed: () {
          clearTextInput();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        },
        child: Text("Login Now",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[900],
        toolbarHeight: 150,
        leading: BackButton(
          color: Colors.white,
        ),
        elevation: 0.0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children:[
            Image.asset(
                    "assets/GoBabyGo_WEBLOGO.png",
                    fit: BoxFit.contain,
                    alignment: FractionalOffset.center,
                    height: 100,
                  
                  ),
          ]
      ),
        
          
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.orange[900],
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
              //padding: EdgeInsets.all(30),
                child: Text(
                  "Login",
                  textAlign: TextAlign.left,
                  style: style.copyWith( fontSize: 25,
                    color: Colors.white, fontWeight: FontWeight.bold))
              ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                    ),
                  emailField,
                  SizedBox(
                    height: 35.0,
                  ),
                  passwordField,
                  SizedBox(
                    height: 100.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )
            )
          ],
        )        
      
      /*body: Row(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Expanded(child: Container(
                color: Colors.orange[900],
                height: 200.0,
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset(
                    "assets/GoBabyGo_WEBLOGO.png",
                    fit: BoxFit.contain,
                  ),
                ),
                ),
              ),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  SizedBox(
                    height: 45.0,
                    ),
                  passwordField,
                  SizedBox(
                    height: 35.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 35.0,
                  ),
                  backButton,
                  SizedBox(
                    height: 15.0,
                  ),
              ],
            ),
        ],
      ),
      */
    );
  }
}