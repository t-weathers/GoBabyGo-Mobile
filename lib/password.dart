import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_app/welcome.dart';

class Password extends StatefulWidget {
  Password({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PasswordState createState() => _PasswordState();
}

//first page on login

class _PasswordState extends State<Password> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', color: Colors.white, fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final passwordField = TextField(
        obscureText: true,
        style: style,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color.fromRGBO(235, 152, 78, 1.0),
          //border on load (not clicked)
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
          //border when clicked
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(32.0),
          ),
        ));
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.orange[800],
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //THIS IS WHERE THE BUTTON CLICK GOES
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final backButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        //THIS IS WHERE THE BUTTON CLICK GOES
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Back",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.orange[800], fontWeight: FontWeight.bold)),
      ),
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
                SizedBox(height: 45.0),
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
          ),
        ),
      ),
    );
  }
}
