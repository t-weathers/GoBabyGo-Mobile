import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class profile extends StatefulWidget{
  profile({Key key, this.gsi}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
    );
  }
}