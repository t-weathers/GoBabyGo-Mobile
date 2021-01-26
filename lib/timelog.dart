import 'package:flutter/material.dart';

class timelog extends StatefulWidget{
  @override
  _timelogState createState() => _timelogState();
}

class _timelogState extends State<timelog>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Time Log'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
    );
  }
}