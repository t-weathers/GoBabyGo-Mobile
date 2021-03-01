import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dialog.dart';


class Category {
  //final int id;
  final String categoryName;
  final List<String> activityNames;

  Category({this.categoryName, this.activityNames});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
        categoryName: json["CategoryName"],
        activityNames: json["Activities"]
    );
  }
}
//
// class Activity {
//   final int id;
//   final String activityName;
//   final String description;
//   final String disclaimer;
//   final List<Steps> steps;
//
// }

class activities extends StatefulWidget{
  @override
  _activitiesState createState() => _activitiesState();
}

class _activitiesState extends State<activities> {
  final dbRef = FirebaseDatabase.instance.reference().child("Categories_test");
  final dbRefAct = FirebaseDatabase.instance.reference().child("Categories_test/Activities");
  List<Map<dynamic, dynamic>> lists = [];
  final catArray = ["Zero", "One"];
  final actArray = ["Activity0", "Activity1"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
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
                       int actIndex = index;
                       String activityArray;
                       while(actArray.length != 0) {
                         print(lists[index][catArray[index]]["Activity" +
                             actIndex.toString()])  ;
                         actIndex++;
                         actArray.length--;
                         //print(activityArray);
                       }
                       print(lists[index][catArray[index]]["categoryName"]);
                     },
                   child: Card(
                     child: Center(
                      child: Text(lists[index][catArray[index]]["categoryName"], style: TextStyle(fontSize:18, color:Colors.grey[600]))
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



// return GridView.builder(
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
// itemCount: lists.length,
// itemBuilder: (BuildContext context, int index){
// return Container(
// child: Card(
// child: Center(
// child: Text(lists[index][catArray[index]]["categoryName"], style: TextStyle(fontSize:18, color:Colors.grey[600]))
// )
// )
// );
// });
// }

// GridTile(
// child: Text(lists[index][catArray[index]]["CategoryName"],style: TextStyle(fontSize:18, color:Colors.grey[600]))