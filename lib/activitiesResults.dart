
// import 'package:flutter/dart.html';
// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/activitiesData.dart';
import 'package:testing_app/activityPage.dart';
import 'package:testing_app/user.dart';

class activitiesResults extends StatelessWidget{

  final activitiesData data;
  user userInfo;

  activitiesResults({this.data, this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${data.categoryName}', style: TextStyle(color: Colors.white, fontSize:24)),
          backgroundColor: Colors.orange[900],
          centerTitle: true,
      ),
        body: new SingleChildScrollView(
        child: new Column(
          children: [
            new Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              alignment: Alignment(-1.0, 1.0),
              child: new Text("Select an activity", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: data.activityNames.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(width: 3, color: Colors.orange[900])),
                  child: InkWell(
                    onTap: (){
                      print("This is the activity that got tapped on: " + '${data.activityNames[index]}');
                      Text("This is the activity that got tapped on: " + '${data.activityNames[index]}');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => activityPage(
                          activityName: this.data.activityNames[index],
                          userInfo: userInfo
                      )
                      ));
                    },
                    child: ListTile(
                      title: Text('${data.activityNames[index]}', style: TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
                    )
                )
                );
              },
            )
          ],
        )
        ),
        );
  }
}