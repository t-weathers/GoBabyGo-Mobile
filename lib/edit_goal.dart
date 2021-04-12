import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class editGoal extends StatefulWidget{
  @override
  _editGoalState createState() => _editGoalState();
}

class _editGoalState extends State<editGoal>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Edit Goal', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          //automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Container(
          child: Center(
              child: Text("editGoal")
          ),
        )
    );
  }

}