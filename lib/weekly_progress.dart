import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class weeklyProgress extends StatefulWidget{
  @override
  _weeklyProgressState createState() => _weeklyProgressState();
}

class _weeklyProgressState extends State<weeklyProgress>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Weekly Progress', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          //automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Container(
          child: Center(
              child: Text("Weekly Progress")
          ),
        )
    );
  }

}