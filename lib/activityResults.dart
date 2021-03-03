import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class activityResults extends StatefulWidget{
  @override
  _activityResultsState createState() => _activityResultsState();
}

class _activityResultsState extends State<activityResults> {

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    print(args);
    print(categoryArguements.categoryName);
    // final String category = ModalRoute.of(context).settings.arguments;
    //final List<String> activities = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text("Activities2", style: TextStyle(color: Colors.white, fontSize:24)),
    backgroundColor: Colors.orange[900],
    ),
      body: Text("These are the arguements: " )
    );
  }
}