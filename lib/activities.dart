import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activitiesResults.dart';
import 'dialog.dart';

class activities extends StatefulWidget{
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  final dbRef = FirebaseDatabase.instance.reference().child("Categories");
  List<Map<dynamic, dynamic>> lists = [];
  final catArray = ["One", "Two"];
  final actArray = ["Activity0", "Activity1"];

  //Adding:
  //final activitiesData data = activitiesData(categoryName: 'test', activityNames: ["test1", "test2"]);
  List<String> activitesArray = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities', style: TextStyle(color: Colors.white, fontSize:24)),
        backgroundColor: Colors.orange[900],

        centerTitle: true;
      ),
      body: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
            if(snapshot.hasData){
              lists.clear();
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, value){
                lists.add(values);
              });

           return GridView.builder(
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
               itemCount: lists.length,
               itemBuilder: (BuildContext context, int index){
                 return Container(
                   child: Material(
                     child: InkWell(
                     onTap: (){
                       if (activitesArray != null){
                         activitesArray.clear();
                         print ("This is the activities array cleared:");
                         print(activitesArray);
                       }
                       int actIndex = 0;
                       int actLength = actArray.length;
                       while(actLength != 0) {
                         print("activity:" + lists[index][catArray[index]]["Activity" +
                             actIndex.toString()])  ;
                         activitesArray.add(lists[index][catArray[index]]["Activity" +
                             actIndex.toString()]);
                         actIndex++;
                         actLength--;
                       }
                       print ("This is the activities array:");
                       print(activitesArray);
                       print(lists[index][catArray[index]]["CategoryName"]);
                       final activitiesData data = activitiesData(categoryName: lists[index][catArray[index]]["CategoryName"], activityNames: activitesArray);
                       Navigator.push(context,
                       MaterialPageRoute(builder: (context) => activitiesResults(
                         data: data,
                       )));

                     },
                   child: Card(
                     child: Center(
                      child: Text(lists[index][catArray[index]]["CategoryName"], style: TextStyle(fontSize:18, color:Colors.grey[600]))
                     )
                   )
                 )
                 )
                 );
               });
            }
            return CircularProgressIndicator();
          }
          )
    );
  }
}