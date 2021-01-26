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
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Explore your next activity",
                  textAlign: TextAlign.center),
              SizedBox(height:20.0,),
              Text("Recent activity"),
              SizedBox(height:25.0,),
              Text("Categories"),

            ],
        ),


      ),
    );
  }
}