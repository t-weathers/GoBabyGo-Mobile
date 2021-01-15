import 'package:flutter/material.dart';

class forum extends StatefulWidget{
  @override
  _forumState createState() => _forumState();
}

class _forumState extends State<forum>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
        backgroundColor: Colors.grey,
        centerTitle: true,
      ),
    );
  }
}