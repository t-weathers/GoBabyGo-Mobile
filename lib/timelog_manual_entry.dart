import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class timelogManualEntry extends StatefulWidget{
  @override
  _timeLogManualEntryState createState() => _timeLogManualEntryState();
}

class _timeLogManualEntryState extends State<timelogManualEntry>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Time Log', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("Time log manual entry")
        ),
      )
    );
  }
  
}