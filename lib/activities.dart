import 'package:flutter/material.dart';

class activities extends StatefulWidget{
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
    );
  }
}