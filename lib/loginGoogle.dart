import 'dart:math';

import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:testing_app/user_model.dart';

import 'create_account_parent.dart';

class LoginGoogle extends StatefulWidget {
    LoginGoogle({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginGoogle createState() => _LoginGoogle();
}

class _LoginGoogle extends State<LoginGoogle>{
  final _formKey = GlobalKey<FormState>();
  New_User _new_user = new New_User();
  String userTypeString;  //"Parent","Clinician","Administrator","Other"
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:Colors.white,
        ),
        backgroundColor: Colors.orange[900],
        title: Text("Login with Google",style: TextStyle(color: Colors.white)),
        centerTitle: false,
        
      ),
      body: new Container(
        color: Colors.white,
        
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  alignment: Alignment.topCenter,
                  
                  
                  color: Colors.orange[900],
                  child: Image.asset(
                    "assets/GoBabyGo_WEBLOGO.png",
                    
                    fit: BoxFit.contain,
                    alignment: FractionalOffset.center,
                    height: 100,
                  
                  ),
                ),
                SizedBox(height:30),
              Container(
                  
                  padding: EdgeInsets.all(30),
                  
                  color: Colors.white,
                  child: Form(
                    child: Column(
                      
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: <Widget>[
                      TextFormField( //first name
                        onSaved: (val) => _new_user.fName = val,
                        
                        validator: (val){
                          if(val.isEmpty) return "This field is required";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                        )
                      ),
                      SizedBox(height:30),
                      TextFormField( //first name
                        onSaved: (val) => _new_user.fName = val,
                        
                        validator: (val){
                          if(val.isEmpty) return "This field is required";
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                        )
                      ),
                      
                      
                      SizedBox(height:30),
                      _createAccountButton(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ]
        )
      )
    ));
  }
  Widget _createAccountButton(){
    return RaisedButton(
      splashColor: Colors.grey,
      color: Colors.orange[900],
      onPressed: () {
        //add validation,
        //push to next create acct page
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          Navigator.pushNamedAndRemoveUntil(context, "/MyHomePage", (_) => false);  //go to next page with no possibility to go back
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      
      
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

