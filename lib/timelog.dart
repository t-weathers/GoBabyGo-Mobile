import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class timelog extends StatefulWidget{
  timelog({Key key, this.gsi}) : super(key: key);
  //final String gsi;
  final GoogleSignInAccount gsi;


  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Time Log', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: Center(
        child:
    Text(widget.gsi.email)

      )
    );
  }
}